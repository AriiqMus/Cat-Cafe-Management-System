<%-- 
    Document   : customerEditProfile
    Created on : Jun 17, 2025, 1:09:50 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Customers" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Edit My Profile</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #fcd56a;
                margin: 0;
                padding: 0;
            }

            main {
                padding: 30px;
                max-width: 500px;
                margin: 50px auto;
                background-color: #f0eacb;
                border-radius: 20px;
                border: 3px solid black;
                box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            }

            h2 {
                text-align: center;
                margin-bottom: 30px;
            }

            form {
                display: flex;
                flex-direction: column;
            }

            label {
                margin: 10px 0 5px;
                font-weight: bold;
            }

            input[type="text"],
            input[type="email"],
            input[type="password"] {
                padding: 12px;
                border: 2px solid black;
                border-radius: 8px;
                font-size: 16px;
            }

            .btn-container {
                margin-top: 20px;
                text-align: center;
            }

            button {
                background-color: #3cb043;
                color: white;
                padding: 10px 30px;
                font-size: 18px;
                border: none;
                border-radius: 50px;
                cursor: pointer;
            }

            button:hover {
                background-color: #2d8c32;
            }

            .back-link {
                display: block;
                margin-top: 20px;
                text-align: center;
                color: #4b3621;
                text-decoration: none;
                font-weight: bold;
            }
        </style>
    </head>
    <body>

        <main>
            <h2>Edit My Profile</h2>

            <form action="UpdateProfileServlet" method="post">
                <input type="hidden" name="customerId" value="<%= request.getAttribute("customerId")%>">

                <label for="username">Username</label>
                <input type="text" name="username" value="<%= request.getAttribute("customerUsername")%>" required>

                <label for="email">Email</label>
                <input type="email" name="email" value="<%= request.getAttribute("customerEmail")%>" required>

                <label for="phone">Phone</label>
                <input type="text" name="phone" value="<%= request.getAttribute("customerPhone")%>" required>

                <label for="password">New Password</label>
                <input type="password" name="password" placeholder="Leave blank to keep current">

                <div class="btn-container">
                    <button type="submit">Save Changes</button>
                </div>
            </form>

            <a class="back-link" href="ProfileServlet">← Back to Profile</a>
        </main>

    </body>
</html>
