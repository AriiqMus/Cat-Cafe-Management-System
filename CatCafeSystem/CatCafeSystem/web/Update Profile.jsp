<%-- 
    Document   : Update Profile
    Created on : 14 Jun 2025, 9:14:23 am
    Author     : Muhammad Syakil bin Mohd Zaidi
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Profile</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }
        main {
            margin: 50px auto;
            max-width: 400px;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 6px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .update-btn {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            margin-top: 15px;
            border-radius: 5px;
            cursor: pointer;
        }
        .error {
            margin-top: 10px;
            color: red;
            background: #ffe0e0;
            padding: 10px;
            border-radius: 4px;
        }
    </style>
</head>
<body>

<main>
    <h2>Update Profile</h2>
    <form action="Profile" method="post">
        <label>Email:</label>
        <input type="email" name="email" />

        <label>Phone:</label>
        <input type="text" name="phone" />

        <label>New Username:</label>
        <input type="text" name="newUsername" />

        <label>New Password:</label>
        <input type="password" name="password" />

        <button class="update-btn"><i class="fas fa-save"></i> Update</button>
    </form>

    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
       <div class="error"><%= error %></div>
    <% } %>
</main>

</body>
</html>
