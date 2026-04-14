<%-- 
    Document   : Login
    Created on : 24 May 2025, 4:42:15 pm
    Author     : Muhammad Syakil bin Mohd Zaidi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Login - Cat Diary Cafe</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #fcd56a;
                margin: 0;
                padding: 0;
                color: #000;
            }

            main {
                max-width: 400px;
                margin: 60px auto;
                background-color: #fff8e1;
                padding: 30px;
                border-radius: 20px;
                border: 3px solid #4b3621;
                box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
            }

            h2 {
                text-align: center;
                margin-bottom: 30px;
                font-family: 'Castely', cursive;
                color: #4b3621;
                font-size: 32px;
            }

            form {
                display: flex;
                flex-direction: column;
            }

            label {
                font-weight: bold;
                margin-bottom: 8px;
                color: #4b3621;
                text-align: left;
            }

            input[type="text"],
            input[type="password"] {
                padding: 12px;
                margin-bottom: 20px;
                border: 2px solid #4b3621;
                border-radius: 10px;
                font-size: 16px;
                background-color: #fffaf0;
                color: #000;
            }

            .login-btn {
                background-color: #ffdd95;
                color: #4b3621;
                padding: 14px;
                border: none;
                border-radius: 25px;
                font-size: 18px;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .login-btn:hover {
                background-color: #ffe8b6;
            }

            .register-link {
                text-align: center;
                margin-top: 20px;
                font-size: 14px;
                color: #4b3621;
            }

            .register-link a {
                color: #4b3621;
                text-decoration: underline;
                font-weight: bold;
            }

            .register-link a:hover {
                color: #000;
            }

            /* Cute floating staff button */
            .staff-button {
                position: fixed;
                bottom: 30px;
                right: 30px;
                background-color: #ffdd95;
                color: #4b3621;
                padding: 14px 22px;
                border-radius: 50px;
                font-weight: bold;
                font-family: 'Poppins', cursive;
                box-shadow: 0 4px 10px rgba(0,0,0,0.2);
                font-size: 14px;
                text-decoration: none;
                transition: all 0.3s ease;
            }

            .staff-button:hover {
                background-color: #ffe8b6;
                transform: scale(1.1);
            }
        </style>
    </head>
    <body>

        <jsp:include page="header.jsp">
            <jsp:param name="page" value="home" />
        </jsp:include>

        <main>
            <h2>Login</h2>

            <% String registerSuccess = (String) request.getAttribute("Register"); %>
            <% String error = (String) request.getAttribute("loginError"); %>
            <% if (registerSuccess != null) {%>
            <div style="color: green; text-align: center; margin-bottom: 20px;">
                <%= registerSuccess%>
                <% request.setAttribute("Register", null); %>
            </div>
            <% } %>
            <% if (error != null) {%>
            <div style="color: red; text-align: center; margin-bottom: 20px;">
                <%= error%>
            </div>
            <% }%>

            <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" placeholder="Enter your username" required>

                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>

                <button type="submit" class="login-btn"><i class="fas fa-sign-in-alt"></i> Login</button>
            </form>

            <div class="register-link">
                Don't have an account? <a href="RegisterServlet">Register here</a>
            </div>
        </main>

        <!-- Cute staff button -->
        <a href="StaffLoginPage.jsp" class="staff-button">🐾 psst! you work here?</a>

    </body>
</html>
