<%@page import="java.util.List"%>
<%@page import="model.Order"%>
<%@page import="dao.StaffOrderDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="staffOrders2.css">
    <title>Order Management</title>
</head>
<body>
    <jsp:include page="header.jsp">
            <jsp:param name="page" value="editCat" />
        </jsp:include>

    <div class="container">
        <h1>Order Management</h1>
        
        <div class="filter-section">
            <a href="staffOrderList.jsp" class="filter-btn <%= request.getParameter("status") == null ? "active" : "" %>">All Orders</a>
            <a href="staffOrderList.jsp?status=PENDING" class="filter-btn <%= "PENDING".equals(request.getParameter("status")) ? "active" : "" %>">Pending</a>
            <a href="staffOrderList.jsp?status=PAID" class="filter-btn <%= "PAID".equals(request.getParameter("status")) ? "active" : "" %>">Paid</a>
            <a href="staffOrderList.jsp?status=COMPLETED" class="filter-btn <%= "COMPLETED".equals(request.getParameter("status")) ? "active" : "" %>">Completed</a>
            <a href="staffOrderList.jsp?status=CANCELLED" class="filter-btn <%= "CANCELLED".equals(request.getParameter("status")) ? "active" : "" %>">Cancelled</a>
        </div>
        
        <div class="orders-table">
            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Type</th>
                        <th>Date</th>
                        <th>Total</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String statusFilter = request.getParameter("status");
                        List<Order> orders;
                        
                        if (statusFilter != null && !statusFilter.isEmpty()) {
                            orders = StaffOrderDAO.getOrdersByStatus(statusFilter);
                        } else {
                            orders = StaffOrderDAO.getAllOrders();
                        }
                        
                        if (orders.isEmpty()) {
                    %>
                            <tr>
                                <td colspan="7" class="no-orders">No orders found</td>
                            </tr>
                    <%
                        } else {
                            for (Order order : orders) {
                    %>
                                <tr>
                                    <td><%= order.getOrderID() %></td>
                                    <td>
                                        <% if (order.getCustomerName() != null) { %>
                                            <%= order.getCustomerName() %>
                                        <% } else { %>
                                            Guest
                                        <% } %>
                                    </td>
                                    <td><%= order.getOrderType() %></td>
                                    <td><%= order.getOrderDate() %></td>
                                    <td>RM <%= String.format("%.2f", order.getTotalAmount()) %></td>
                                    <td>
                                        <span class="status <%= order.getStatus().toLowerCase() %>">
                                            <%= order.getStatus() %>
                                        </span>
                                    </td>
                                    <td class="actions">
                                        <a href="staffOrderDetails.jsp?orderID=<%= order.getOrderID() %>" class="view-btn">
                                            <i class="fas fa-eye"></i> View
                                        </a>
                                        <% if (!"COMPLETED".equals(order.getStatus()) && !"CANCELLED".equals(order.getStatus())) { %>
                                            <a href="#" class="edit-btn" onclick="showStatusModal(<%= order.getOrderID() %>, '<%= order.getStatus() %>')">
                                                <i class="fas fa-edit"></i> Update
                                            </a>
                                        <% } %>
                                    </td>
                                </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
    
    <!-- Status Update Modal -->
    <div id="statusModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h2>Update Order Status</h2>
            <form id="statusForm" action="UpdateOrderStatusServlet" method="POST">
                <input type="hidden" id="modalOrderID" name="orderID">
                
                <div class="form-group">
                    <label for="status">New Status:</label>
                    <select id="status" name="status" class="form-control">
                        <option value="PENDING">Pending</option>
                        <option value="PAID">Paid</option>
                        <option value="COMPLETED">Completed</option>
                        <option value="CANCELLED">Cancelled</option>
                    </select>
                </div>
                
                <button type="submit" class="btn btn-primary">Update Status</button>
            </form>
        </div>
    </div>
    
    <script>
        function showStatusModal(orderID, currentStatus) {
            document.getElementById('modalOrderID').value = orderID;
            document.getElementById('status').value = currentStatus;
            document.getElementById('statusModal').style.display = 'block';
        }
        
        function closeModal() {
            document.getElementById('statusModal').style.display = 'none';
        }
        
        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('statusModal');
            if (event.target === modal) {
                closeModal();
            }
        }
    </script>
</body>
</html>