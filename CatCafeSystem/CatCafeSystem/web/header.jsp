<%-- 
    Document   : header
    Created on : 24 May 2025, 10:36:01 pm
    Author     : sitif
--%>

<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Cat Diary Cafe</title>

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Pacifico&family=Poppins&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Cherry+Bomb+One&display=swap" rel="stylesheet">

        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <!-- Your own CSS file -->
        <link rel="stylesheet" href="styles.css">

        <style>
            @font-face {
                font-family: 'Castely';
                src: url('fonts/Castely.otf') format('opentype');
            }

            body {
                background-color: #fcd56a;
                font-family: 'Poppins', sans-serif;
                margin: 0;
                color: #000;
            }

            header {
                background-color: #f0eacb;
                border-bottom: 3px solid #4b3621;
            }

            .nav {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px 30px;
            }

            .nav h1 {
                font-family: 'Castely', cursive;
                font-size: 28px;
                margin: 0;
                color: #4b3621;
            }

            nav a {
                margin: 0 15px;
                text-decoration: none;
                font-weight: 600;
                color: #4b3621;
            }

            nav a.active, nav a:hover {
                text-decoration: underline;
            }

            .user-icon {
                margin-left: 20px;
                font-size: 20px;
                color: #4b3621;
            }

            .welcome-title {
                font-family: 'Cherry Bomb One', cursive;
                font-size: 60px;
                text-align: center;
                margin-top: 60px;
                color: #4b3621;
                letter-spacing: 4px;
            }

            .hero-image {
                display: flex;
                justify-content: center;
                margin: 40px 0;
            }

            .hero-image img {
                width: 70%;
                border-radius: 30px;
                border: 5px solid #4b3621;
                box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            }

            .home-grid {
                display: flex;
                justify-content: center;
                gap: 40px;
                padding: 40px;
                flex-wrap: wrap;
            }

            .home-card {
                background-color: #f0eacb;
                padding: 30px 50px;
                font-size: 24px;
                text-decoration: none;
                color: #000;
                border: 3px solid #4b3621;
                border-radius: 20px;
                font-weight: bold;
                transition: transform 0.2s;
            }

            .home-card:hover {
                transform: scale(1.05);
                background-color: #ffeaa7;
            }

            footer {
                text-align: center;
                padding: 20px;
                background-color: #f0eacb;
                border-top: 3px solid #4b3621;
                margin-top: 60px;
                color: #4b3621;
                font-size: 14px;
            }

            .cart-link {
                margin-left: 20px;
                font-size: 20px;
                color: #4b3621;
                position: relative;
                text-decoration: none;
            }

            .cart-link:hover {
                text-decoration: underline;
            }

            #cartCount {
                position: absolute;
                top: -8px;
                right: -10px;
                background-color: red;
                color: white;
                font-size: 12px;
                font-weight: bold;
                padding: 2px 6px;
                border-radius: 50%;
            }

        </style>
    </head>
    <body>
        <header>
            <div class="nav">
                <h1>Cat Diary Cafe</h1>

                <%
                    String currentPage = request.getParameter("page");
                    if (currentPage == null) {
                        currentPage = ""; // default
                    }

                    // Define pages that should NOT show nav bar
                    boolean showNav = !(currentPage.equals("editCat") || currentPage.equals("adminOnly") || currentPage.equals("hideNav"));
                %>

                <% if (showNav) {%>
                <nav>
                    <a href="HomepageServlet" class="<%= "home".equals(currentPage) ? "active" : ""%>">Home</a>
                    <a href="CustBookingServlet" class="<%= "booking".equals(currentPage) ? "active" : ""%>">Booking</a>

                    <% if ("menu".equals(currentPage)) {%>
                    <a href="CustMenuServlet?page=menu" class="<%= "menu".equals(currentPage) ? "active" : ""%>">Menu</a>
                    <a href="viewCart.jsp" class="cart-link" title="Cart">
                        <i class="fa-solid fa-cart-shopping"></i>
                        <span id="cartCount">
                            <%= session.getAttribute("cart") != null ? ((List<?>) session.getAttribute("cart")).size() : 0%>
                        </span>
                    </a>
                    <% }%>

                    <a href="CatProfileServlet" class="<%= "cat".equals(currentPage) ? "active" : ""%>">Cat</a>
                    <a href="LoginServlet" title="Login">
                        <i class="fas fa-user user-icon"></i>
                    </a>
                </nav>
                <% }%>


            </div>
        </header>


