<%-- 
    Document   : SpecialAccessLogin
    Created on : 15 Jun 2025, 2:34:08 pm
    Author     : Muhammad Syakil bin Mohd Zaidi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>Login - Cat Diary Cafe</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fefefe;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #fbd56a;
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

        main {
            max-width: 400px;
            margin: 60px auto;
            background-color: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
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
            font-weight: bold;
            margin-bottom: 6px;
        }

        input[type="text"],
        input[type="password"] {
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        .login-btn {
            background-color: #fbd56a;
            color: black;
            padding: 12px;
            border: none;
            border-radius: 25px;
            font-size: 16px;
            cursor: pointer;
        }

        .login-btn:hover {
            background-color: #ff8e93;
        }

        .register-link {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }

        .register-link a {
            color: blue;
            text-decoration: none;
        }

        .register-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<header>
    <div class="nav">
        <h1>Cat Diary Cafe</h1>
    </div>
</header>

<main>
    <h2>Login</h2>
    <% String registerSuccess = (String) request.getAttribute("Register"); %>
    <% String error = (String) request.getAttribute("loginError"); %>
    <% if (registerSuccess != null) { %>
    <div style="color: green; text-align: center; margin-bottom: 20px;">
            <%= registerSuccess %>
            <% request.setAttribute("Register", null); %>
    </div>
    <% } %>
    <% if (error != null) { %>
        <div style="color: red; text-align: center; margin-bottom: 20px;">
            <%= error %>
        </div>
    <% } %>
    <form action="SpecialAccessLogin" method="post">
    <label for="username">Username</label>
    <input type="text" id="username" name="username" placeholder="Enter your username" required>

    <label for="password">Password</label>
    <input type="password" id="password" name="password" placeholder="Enter your password" required>

    <label>Access Type</label>
    <fieldset style="margin-bottom: 20px;">
        <label><input type="radio" name="userType" value="admin"> Admin</label><br>
        <label><input type="radio" name="userType" value="staff"> Staff</label>
    </fieldset>

    <button type="submit" class="login-btn"><i class="fas fa-sign-in-alt"></i>Login</button>
</form>

    <div class="register-link">
        Don't have an account? <a href="SpecialAccessLogin?action=register">Register here</a>
    </div>
    <div class="register-link">
        <br><a href="SpecialAccessLogin?action=specialAccess">Special Access</a>
    </div>
</main>

</body>
</html>