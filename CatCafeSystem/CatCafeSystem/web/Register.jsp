<%-- 
    Document   : Register
    Created on : 26 May 2025, 8:35:17 am
    Author     : Muhammad Syakil bin Mohd Zaidi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Register - Cat Diary Cafe</title>
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
            .register-btn {
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
            .register-btn:hover {
                background-color: #ffe8b6;
            }

            .back-button {
                display: inline-block;
                margin-bottom: 15px;
                font-size: 1rem;
                color: #4b3621;
                text-decoration: none;
                font-weight: bold;
                background-color: #ffe9a7;
                padding: 8px 14px;
                border: 2px solid #4b3621;
                border-radius: 10px;
                transition: background-color 0.3s ease;
            }

            .back-button:hover {
                background-color: #ffda6c;
            }
        </style>
    </head>
    <body>

        <main>
            <h2>Register</h2>
            <form action="${pageContext.request.contextPath}/RegisterServlet" method="post">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>

                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>

                <label for="email">Email</label>
                <input type="text" id="email" name="email" required>

                <button type="submit" class="register-btn"><i class="fas fa-user-plus"></i> Register</button>
            </form>
        </main>
        <a href="Login.jsp" class="back-button">← Back to Profiles</a>

    </body>
</html>
