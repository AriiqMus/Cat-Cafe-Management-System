<%-- 
    Document   : checkout
    Created on : 17 Jun 2025, 1:33:47 am
    Author     : Ariiq
--%>

<%@page import="model.Menu"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="styleCart.css"/>
        <title>Checkout - Cat Diary Cafe</title>
        <style>
            .checkout-container {
                max-width: 800px;
                margin: 20px auto;
                padding: 20px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }

            .checkout-section {
                display: flex;
                gap: 30px;
            }

            .order-summary, .payment-form {
                flex: 1;
            }

            .payment-methods {
                margin-bottom: 20px;
            }

            .payment-method {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
            }

            .payment-method input {
                margin-right: 10px;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: 500;
            }

            .form-group input {
                width: 90%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 16px;
            }

            .card-icons {
                display: flex;
                gap: 10px;
                margin-top: 10px;
            }

            .card-icons img {
                height: 30px;
            }

            .submit-btn {
                background: #4CAF50;
                color: white;
                border: none;
                padding: 12px 20px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                font-weight: 600;
                width: 100%;
                margin-top: 10px;
            }

            .alert.error {
                color: #721c24;
                background-color: #f8d7da;
                padding: 10px;
                border-radius: 4px;
                margin: 10px 0;
            }

            .continue-btn {
                display: inline-block;
                margin-top: 15px;
                color: #0069d9;
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp">
            <jsp:param name="page" value="editCat" />
        </jsp:include>

        <div class="checkout-container">
            <h1>Checkout</h1>

            <% if (request.getAttribute("error") != null) {%>
            <div class="alert error">
                <%= request.getAttribute("error")%>
            </div>
            <% } %>

            <div class="checkout-section">
                <div class="order-summary">
                    <h2>Your Order</h2>
                    <%
                        List<Menu> cart = (List<Menu>) request.getAttribute("cartItems");
                        Double total = (Double) request.getAttribute("total");

                        if (cart != null && !cart.isEmpty() && total != null) {
                            for (Menu item : cart) {
                    %>
                    <div class="cart-item">
                        <div class="item-details">
                            <h3><%= item.getName()%></h3>
                            <p><%= item.getQuantity()%> x RM <%= String.format("%.2f", item.getPrice())%></p>
                        </div>
                        <div class="item-total">
                            RM <%= String.format("%.2f", item.getPrice() * item.getQuantity())%>
                        </div>
                    </div>
                    <%
                        }
                    %>
                    <div class="cart-total">
                        <h3>Total: RM <%= String.format("%.2f", total)%></h3>
                    </div>
                    <%
                    } else {
                    %>
                    <div class="alert error">Your cart is empty or an error occurred.</div>
                    <a href="ManageMenuCust.jsp" class="continue-btn">Back to Menu</a>
                    <%
                        }
                    %>

                    <a href="viewCart.jsp" class="continue-btn">
                        <i class="fas fa-chevron-left"></i> Back To Cart 
                    </a>
                </div>

                <div class="payment-form">
                    <h2>Payment Method</h2>
                    <form method="post" action="CheckoutServlet">
                        <input type="hidden" name="orderType" value="<%= request.getParameter("orderType") != null ? request.getParameter("orderType") : "TAKEAWAY"%>">
                        <div class="payment-methods">
                            <div class="payment-method">
                                <input type="radio" id="creditCard" name="payment_method" value="Credit Card" checked>
                                <label for="creditCard">Credit/Debit Card</label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="cardNumber">Card Number</label>
                            <input type="text" id="cardNumber" name="cardNumber" placeholder="1234 5678 9012 3456" required>
                        </div>

                        <div class="form-group">
                            <label for="nameOnCard">Name on Card</label>
                            <input type="text" id="nameOnCard" name="nameOnCard" placeholder="Lee Guang En" required>
                        </div>

                        <div style="display: flex; gap: 15px;">
                            <div class="form-group" style="flex: 1;">
                                <label for="expiryDate">Expiry Date</label>
                                <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YY" required>
                            </div>

                            <div class="form-group" style="flex: 1;">
                                <label for="cvv">CVV</label>
                                <input type="text" id="cvv" name="cvv" placeholder="123" required>
                            </div>
                        </div>

                        <div class="card-icons">
                            <i class="fab fa-cc-visa" style="font-size: 30px; color: #1a1f71;"></i>
                            <i class="fab fa-cc-mastercard" style="font-size: 30px; color: #eb001b;"></i>
                        </div>

                        <button type="submit" class="submit-btn">
                            Complete Payment
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>