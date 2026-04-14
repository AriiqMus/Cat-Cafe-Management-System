<%-- 
    Document   : registerStaff
    Created on : Jun 17, 2025, 11:40:16 AM
    Author     : User
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>Register Staff</title>
        <link rel="stylesheet" href="styles.css" />
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #fffdf7;
                margin: 0;
                padding: 0;
            }
            .register-container {
                width: 500px;
                margin: 80px auto;
                background-color: #fff8e1;
                border: 2px solid #4b3621;
                border-radius: 15px;
                padding: 40px;
                text-align: center;
            }
            h2 {
                font-family: 'Castely', cursive;
                font-size: 2.6rem;
                color: #4b3621;
                margin-bottom: 20px;
            }
            input[type="text"], input[type="password"] {
                width: 80%;
                padding: 12px;
                margin: 10px 0;
                border: 1px solid #4b3621;
                border-radius: 8px;
                font-size: 1rem;
            }
            button {
                padding: 10px 20px;
                font-size: 1rem;
                border: 2px solid #4b3621;
                border-radius: 12px;
                background-color: #f0eacb;
                color: #4b3621;
                cursor: pointer;
            }
            button:hover {
                background-color: #ffe2a8;
            }
        </style>
    </head>
    <body>

        <div class="register-container">
            <h2>Register New Staff 🐾</h2>
            <form action="RegisterStaffServlet" method="post">
                <input type="text" name="staffID" placeholder="Staff ID (e.g. S101)" required /><br/>
                <input type="text" name="name" placeholder="Staff Name" required /><br/>
                <input type="text" name="username" placeholder="Username" required /><br/>
                <input type="password" name="password" placeholder="Password" required /><br/>
                <button type="submit">Register</button>
            </form>
        </div>

    </body>
</html>
