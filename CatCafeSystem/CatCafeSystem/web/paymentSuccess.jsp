<%-- 
    Document   : paymentSuccess
    Created on : 17 Jun 2025, 1:37:41 am
    Author     : sitif
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="styleCart.css"/>
        <title>Order Confirmation - Cat Diary Cafe</title>
        <style>
            .confirmation-container {
                max-width: 600px;
                margin: 50px auto;
                padding: 30px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
                text-align: center;
            }

            .confirmation-icon {
                font-size: 60px;
                color: #4CAF50;
                margin-bottom: 20px;
            }

            .confirmation-message {
                margin-bottom: 30px;
            }

            .order-details {
                background: #f9f9f9;
                padding: 20px;
                border-radius: 8px;
                margin-bottom: 30px;
                text-align: left;
            }

            .order-number {
                font-size: 20px;
                font-weight: 600;
                margin-bottom: 10px;
            }

            .back-to-menu {
                display: inline-block;
                background: #fcd56a;
                color: #333;
                padding: 12px 25px;
                border-radius: 5px;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s;
            }

            .back-to-menu:hover {
                background: #e6c05e;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp">
            <jsp:param name="page" value="editCat" />
        </jsp:include>

        <div class="confirmation-container">
            <div class="confirmation-icon">
                <i class="fas fa-check-circle"></i>
            </div>

            <div class="confirmation-message">
                <h1>Payment Successful!</h1>
                <p>Thank you for your order. We've received your payment.</p>
            </div>

            <div class="order-details">
                <div class="order-number">
                    Order #<%= session.getAttribute("orderNumber")%>
                </div>
                <p>Payment Method: Credit Card</p>
                <p>We've sent a confirmation email to your registered address.</p>
            </div>

            <a href="ManageBookingCust.jsp" class="back-to-menu">
                <i class="fas fa-chevron-left"></i> Back to Home
            </a>
        </div>
    </body>
</html>