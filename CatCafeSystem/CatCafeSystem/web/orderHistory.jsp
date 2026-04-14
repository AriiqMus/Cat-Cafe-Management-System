<%@page import="java.util.List"%>
<%@page import="model.Order"%>
<%@page import="dao.OrderDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="styleOrders.css">
    <title>Order History</title>
</head>
<body>
    <div class="nav">
        <h1>Cat Diary Cafe</h1>
        <ul>
            <li><a href="HomepageServlet">Home</a></li>
            <li><a href="CustBookingServlet">Booking</a></li>
            <li><a href="CatProfileServlet">Cat</a></li>
            <li><a href="LoginServlet"><i class="fa-solid fa-user user-icon"></i></a></li>
        </ul>
    </div>

    <div class="order-history-container">
        <h1>Your Order History</h1>
        
        <% 
            Integer customerId = (Integer) session.getAttribute("customerId");
            if (customerId != null) {
                try {
                    List<Order> orders = OrderDAO.getCustomerOrders(customerId);
                    if (orders.isEmpty()) {
        %>
                        <p class="no-orders">You haven't placed any orders yet.</p>
        <%
                    } else {
        %>
                        <div class="orders-list">
                            <% for (Order order : orders) { %>
                                <div class="order-card">
                                    <div class="order-header">
                                        <span class="order-id">Order #<%= order.getOrderID() %></span>
                                        <span class="order-date"><%= order.getOrderDate() %></span>
                                        <span class="order-status <%= order.getStatus().toLowerCase() %>">
                                            <%= order.getStatus() %>
                                        </span>
                                    </div>
                                    <div class="order-details">
                                        <div>Type: <%= order.getOrderType() %></div>
                                        <div>Total: RM <%= String.format("%.2f", order.getTotalAmount()) %></div>
                                        <a href="orderDetails.jsp?orderID=<%= order.getOrderID() %>" class="view-details">
                                            View Details <i class="fas fa-chevron-right"></i>
                                        </a>
                                    </div>
                                </div>
                            <% } %>
                        </div>
        <%
                    }
                } catch (Exception e) {
        %>
                    <div class="alert error">Error loading orders: <%= e.getMessage() %></div>
        <%
                }
            } else {
        %>
                <div class="alert error">Please login to view your order history.</div>
        <%
            }
        %>
    </div>
</body>
</html>