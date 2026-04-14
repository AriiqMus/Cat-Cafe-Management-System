<%@page import="java.util.List"%>
<%@page import="model.OrderItem"%>
<%@page import="dao.OrderDAO"%>
<%@page import="model.Order"%>
<%@page import="dao.StaffOrderDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="staffOrders2.css">
    <title>Order Details</title>
</head>
<body>
    <jsp:include page="header.jsp">
            <jsp:param name="page" value="editCat" />
        </jsp:include>

    <div class="container">
        <%
            String orderID = request.getParameter("orderID");
            if (orderID != null) {
                try {
                    Order order = StaffOrderDAO.getOrderWithCustomer(Integer.parseInt(orderID));
                    List<OrderItem> items = OrderDAO.getOrderItems(Integer.parseInt(orderID));
                    
                    if (order != null) {
        %>
                        <div class="order-header">
                            <h1>Order #<%= order.getOrderID() %></h1>
                            <a href="staffOrderList.jsp" class="back-btn">
                                <i class="fas fa-arrow-left"></i> Back to Orders
                            </a>
                        </div>
                        
                        <div class="order-info">
                            <div class="info-section">
                                <h3>Order Information</h3>
                                <p><strong>Date:</strong> <%= order.getOrderDate() %></p>
                                <p><strong>Type:</strong> <%= order.getOrderType() %></p>
                                <p><strong>Status:</strong> 
                                    <span class="status <%= order.getStatus().toLowerCase() %>">
                                        <%= order.getStatus() %>
                                    </span>
                                </p>
                                <p><strong>Payment Method:</strong> <%= order.getPaymentMethod() != null ? order.getPaymentMethod() : "N/A" %></p>
                                <% if (order.getTableID() != null) { %>
                                    <p><strong>Table:</strong> <%= order.getTableID() %></p>
                                <% } %>
                            </div>
                            
                            <div class="info-section">
                                <h3>Customer Information</h3>
                                <% if (order.getCustomerName() != null) { %>
                                    <p><strong>Name:</strong> <%= order.getCustomerName() %></p>
                                    <p><strong>Phone:</strong> <%= order.getCustomerPhone() %></p>
                                <% } else { %>
                                    <p>Guest customer</p>
                                <% } %>
                            </div>
                        </div>
                        
                        <div class="order-items">
                            <h2>Order Items</h2>
                            <table>
                                <thead>
                                    <tr>
                                        <th>Item</th>
                                        <th>Quantity</th>
                                        <th>Unit Price</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (OrderItem item : items) { %>
                                        <tr>
                                            <td>
                                                <div class="item-info">
                                                    <% if (item.getMenu().getImageUrl() != null) { %>
                                                        <img src="<%= item.getMenu().getImageUrl() %>" alt="<%= item.getMenu().getName() %>" class="item-image">
                                                    <% } %>
                                                    <%= item.getMenu().getName() %>
                                                </div>
                                            </td>
                                            <td><%= item.getQuantity() %></td>
                                            <td>RM <%= String.format("%.2f", item.getPrice()) %></td>
                                            <td>RM <%= String.format("%.2f", item.getPrice() * item.getQuantity()) %></td>
                                        </tr>
                                    <% } %>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="3" class="total-label">Total:</td>
                                        <td class="total-amount">RM <%= String.format("%.2f", order.getTotalAmount()) %></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                        
                        <% if (!"COMPLETED".equals(order.getStatus()) && !"CANCELLED".equals(order.getStatus())) { %>
                            <div class="status-update">
                                <h3>Update Order Status</h3>
                                <form action="UpdateOrderStatusServlet" method="POST">
                                    <input type="hidden" name="orderID" value="<%= order.getOrderID() %>">
                                    
                                    <select name="status" class="status-select">
                                        <option value="PENDING" <%= "PENDING".equals(order.getStatus()) ? "selected" : "" %>>Pending</option>
                                        <option value="PAID" <%= "PAID".equals(order.getStatus()) ? "selected" : "" %>>Paid</option>
                                        <option value="COMPLETED" <%= "COMPLETED".equals(order.getStatus()) ? "selected" : "" %>>Completed</option>
                                        <option value="CANCELLED" <%= "CANCELLED".equals(order.getStatus()) ? "selected" : "" %>>Cancelled</option>
                                    </select>
                                    
                                    <button type="submit" class="update-btn">
                                        <i class="fas fa-save"></i> Update Status
                                    </button>
                                </form>
                            </div>
                        <% } %>
        <%
                    } else {
        %>
                        <div class="alert error">Order not found.</div>
        <%
                    }
                } catch (Exception e) {
        %>
                    <div class="alert error">Error loading order details: <%= e.getMessage() %></div>
        <%
                }
            } else {
        %>
                <div class="alert error">No order specified.</div>
        <%
            }
        %>
    </div>
</body>
</html>