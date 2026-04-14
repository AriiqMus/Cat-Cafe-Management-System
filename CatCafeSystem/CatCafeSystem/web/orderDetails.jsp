<%-- 
    Document   : orderDetails
    Created on : 17 Jun 2025, 1:38:22 am
    Author     : Ariiq
--%>

<%@page import="java.util.List"%>
<%@page import="model.OrderItem"%>
<%@page import="dao.OrderDAO"%>
<%@page import="model.Order"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="styleOrders.css">
    <title>Order Details</title>
</head>
<body>
    <div class="nav">
        <h2>Cat Diary Cafe</h2>
        <ul>
            <li><a href="Home.jsp">Home</a></li>
            <li><a href="CustBookingServlet">Booking</a></li>
            <li><a href="Cat.jsp">Cat</a></li>
            <li><a href="Profile.jsp"><i class="fa-solid fa-user user-icon"></i></a></li>
        </ul>
    </div>

    <div class="order-details-container">
        <%
            String orderID = request.getParameter("orderID");
            if (orderID != null) {
                try {
                    Order order = OrderDAO.getOrderDetails(Integer.parseInt(orderID));
                    List<OrderItem> items = OrderDAO.getOrderItems(Integer.parseInt(orderID));
                    
                    if (order != null) {
        %>
                        <h1>Order #<%= order.getOrderID() %></h1>
                        <div class="order-summary">
                            <div><strong>Date:</strong> <%= order.getOrderDate() %></div>
                            <div><strong>Type:</strong> <%= order.getOrderType() %></div>
                            <div><strong>Status:</strong> <span class="status <%= order.getStatus().toLowerCase() %>">
                                <%= order.getStatus() %></span></div>
                            <% if (order.getTableID() != null) { %>
                                <div><strong>Table:</strong> <%= order.getTableID() %></div>
                            <% } %>
                        </div>
                        
                        <div class="order-items">
                            <h2>Items Ordered</h2>
                            <table>
                                <thead>
                                    <tr>
                                        <th>Item</th>
                                        <th>Quantity</th>
                                        <th>Price</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (OrderItem item : items) { %>
                                        <tr>
                                            <td><%= item.getMenu().getName() %></td>
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
                        
                        <a href="orderHistory.jsp" class="back-btn">
                            <i class="fas fa-arrow-left"></i> Back to Order History
                        </a>
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