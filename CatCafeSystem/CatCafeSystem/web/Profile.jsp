<%-- 
    Document   : Profile
    Created on : 14 Jun 2025, 9:13:19 am
    Author     : Muhammad Syakil bin Mohd Zaidi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Date" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>My Profile</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f0f0f0;
            }
            /*        header {
                        background-color: #ffb6b9;
                        padding: 20px;
                    }
                    .nav {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                    }
                    .nav h1 {
                        margin: 0;
                    }
                    nav a {
                        margin: 0 10px;
                        text-decoration: none;
                        color: #333;
                    }
                    .active {
                        font-weight: bold;
                        text-decoration: underline;
                    }*/
            main {
                padding: 20px 10px;
                max-width: 400px;
                max-height: 400px;
                margin: 0 auto;
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            .profile-pic {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                object-fit: cover;
                margin-bottom: 20px;
                border: 3px solid #ffb6b9;
            }
            .profile-info {
                text-align: center;
            }
            .profile-info h2 {
                margin: 10px 0;
            }
            .profile-info p {
                margin: 5px 0;
                font-size: 16px;
            }
            .update-btn {
                display: inline-block;
                margin-top: 20px;
                padding: 10px 20px;
                background-color: #ffb6b9;
                color: white;
                border: none;
                border-radius: 25px;
                cursor: pointer;
                font-size: 16px;
                text-decoration: none;
            }
            .update-btn i {
                margin-right: 8px;
            }
        </style>
    </head>
    <body>

        <!--<header>
            <div class="nav">
                <h1>Cat Diary Cafe</h1>
                <nav>
                    <a href="#">Home0</a>
                    <a href="#">Booking</a>
                    <a href="#">Menu</a>
                    <a href="#">Cat</a>
                    <span class="user-icon active">👤</span>
                </nav>
            </div>
        </header>-->

        <jsp:include page="header.jsp">
            <jsp:param name="page" value="Login" />
        </jsp:include>

        <main>
            <div class="profile-info">
                <img src="https://via.placeholder.com/120" alt="Profile Picture" class="profile-pic">
                <h2>Welcome, <%= request.getAttribute("customerName") != null ? request.getAttribute("customerName") : "Customer"%>!</h2>
                <p><strong>Username:</strong> <%= request.getAttribute("actualUsername")%></p>
                <p><strong>Email:</strong> <%= request.getAttribute("email")%></p>
                <p><strong>Phone:</strong> <%= request.getAttribute("phone")%></p>
                <p><strong>Status:</strong> <%= request.getAttribute("status")%></p>
                <p><strong>Date of Birth:</strong> <%= request.getAttribute("birthDate")%></p>
                <p><strong>Date Registered:</strong> <%= request.getAttribute("dateRegistered")%></p>

                <a class="update-btn" href="Profile?action=update"><i class="fas fa-pen"></i>Update Profile</a>
            </div>
        </main>

    </body>
</html>
