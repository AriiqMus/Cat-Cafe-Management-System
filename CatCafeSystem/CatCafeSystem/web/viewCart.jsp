<%@page import="model.Menu"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="styleCart.css"/>
        <link rel="stylesheet" href="styles.css" />

        <title>Your Shopping Cart</title>
    </head>
    <body>
        <%-- Navigation Bar (same as menu page) --%>
        <!--    <div class="nav">
                <h2>Cat Diary Cafe</h2>
                <ul>
                    <li><a href="Home.jsp">Home</a></li>
                    <li><a href="CustBookingServlet">Booking</a></li>
                    <li><a href="Cat.jsp">Cat</a></li>
                    <li>
                        <a href="viewCart.jsp" class="cart-link">
                            <i class="fa-solid fa-cart-shopping cart-icon"></i>
                            <span id="cartCount"><%= session.getAttribute("cart") != null ? ((List<?>) session.getAttribute("cart")).size() : 0%></span>
                        </a>
                    </li>
                    <li><a href="Profile.jsp"><i class="fa-solid fa-user user-icon"></i></a></li>
                </ul>
            </div>-->


        <!-- Navigation Bar -->
        <jsp:include page="header.jsp">
            <jsp:param name="page" value="menu" />
        </jsp:include>

        <div class="cart-container">
            <h1>Your Shopping Cart</h1>

            <%-- Display cart items --%>
            <div class="cart-items">
                <%
                    List<Menu> cart = (List<Menu>) session.getAttribute("cart");
                    double total = 0;

                    if (cart != null && !cart.isEmpty()) {
                        for (Menu item : cart) {
                            total += item.getPrice() * item.getQuantity();
                %>
                <div class="cart-item">
                    <div class="item-image">
                        <img src="<%= item.getImageUrl() != null ? item.getImageUrl() : "images/default-food.jpg"%>" 
                             alt="<%= item.getName()%>"
                             onerror="this.onerror=null;this.src='images/default-food.jpg'">
                    </div>

                    <div class="item-details">
                        <h3><%= item.getName()%></h3>
                        <p class="item-price">RM <%= String.format("%.2f", item.getPrice())%></p>

                        <%-- Quantity Update Form --%>
                        <form method="post" action="CartServlet" class="quantity-form">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="menuId" value="<%= item.getMenuID()%>">
                            <div class="quantity-controls">
                                <button type="button" class="qty-btn minus" onclick="this.nextElementSibling.stepDown(); this.form.submit();">-</button>
                                <input type="number" name="quantity" value="<%= item.getQuantity()%>" min="1" class="qty-input">
                                <button type="button" class="qty-btn plus" onclick="this.previousElementSibling.stepUp(); this.form.submit();">+</button>
                            </div>
                        </form>
                    </div>

                    <%-- Remove Item Form --%>
                    <div class="item-remove">
                        <form method="post" action="CartServlet">
                            <input type="hidden" name="action" value="remove">
                            <input type="hidden" name="menuId" value="<%= item.getMenuID()%>">
                            <button type="submit" class="remove-btn">
                                <i class="fas fa-trash"></i> Remove
                            </button>
                        </form>
                    </div>

                    <div class="item-total">
                        RM <%= String.format("%.2f", item.getPrice() * item.getQuantity())%>
                    </div>
                </div>
                <%
                    }
                } else {
                %>
                <div class="empty-cart">
                    <i class="fas fa-shopping-cart"></i>
                    <p>Your cart is empty</p>
                </div>
                <% } %>
            </div>

            <%-- Cart Summary --%>
            <% if (cart != null && !cart.isEmpty()) {%>
            <div class="cart-summary">
                <div class="cart-total">
                    <span>Subtotal:</span>
                    <span>RM <%= String.format("%.2f", total)%></span>
                </div>

                <div class="cart-actions">
                    <a href="ManageMenuCust.jsp" class="continue-btn">
                        <i class="fas fa-chevron-left"></i> Continue Shopping
                    </a>
                    <a href="CheckoutServlet" class="checkout-btn">
                        Proceed to Checkout <i class="fas fa-chevron-right"></i>
                    </a>
                </div>
            </div>
            <% } else { %>
            <div class="cart-actions">
                <a href="ManageMenuCust.jsp" class="continue-btn">
                    <i class="fas fa-chevron-left"></i> Back to Menu
                </a>
            </div>
            <% }%>
        </div>
    </body>
</html> 