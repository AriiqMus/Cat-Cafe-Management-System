<%-- 
    Document   : unauthorised
    Created on : 16 Jun 2025, 4:43:39 pm
    Author     : sitif
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Access Denied</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #fff8f0;
            color: #333;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            text-align: center;
            background-color: #ffe2e2;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            max-width: 500px;
        }

        h2 {
            color: #d8000c;
            font-size: 28px;
            margin-bottom: 15px;
        }

        p {
            font-size: 16px;
            margin-bottom: 25px;
        }

        a {
            text-decoration: none;
            background-color: #d8000c;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }

        a:hover {
            background-color: #a60000;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>🚫 Access Denied</h2>
        <p>You are not authorized to view this page.<br>
        Please log in with the correct role (Customer, Staff, or Admin).</p>
        <a href="HomepageServlet">🔙 Return to Home</a>
    </div>
</body>
</html>
