<%-- 
    Document   : editfood
    Created on : 12 May 2025, 10:50:18 pm
    Author     : sitif
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.CatFood" %>

<%
    CatFood food = (CatFood) request.getAttribute("food");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Edit Cat Food</title>
    <link rel="stylesheet" href="styles.css" />
    <style>
        form label {
            display: block;
            margin-top: 15px;
            font-weight: 600;
            font-size: 1.1rem;
        }
        form input[type="text"],
        form input[type="number"] {
            width: 100%;
            padding: 10px;
            font-size: 1rem;
            border: 2px solid black;
            border-radius: 5px;
            box-sizing: border-box;
            margin-top: 5px;
        }
        form button {
            margin-top: 25px;
            background-color: #3cb043;
            color: white;
            border: none;
            padding: 12px 25px;
            font-size: 1.1rem;
            font-weight: bold;
            border-radius: 10px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        form button:hover {
            background-color: #2a7a2a;
        }
        .edit-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            background-color: #f0eacb;
            border-radius: 30px;
            border: 3px solid black;
            box-shadow: 0 5px 10px rgba(0,0,0,0.1);
            font-family: 'Poppins', sans-serif;
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-family: 'Castely', cursive;
            color: #4b3621;
        }
    </style>
</head>
<body>
    <main>
        <div class="edit-container">
            <h2>Edit Cat Food</h2>
            <form action="UpdateFoodServlet" method="post">
                <input type="hidden" name="foodID" value="<%= food.getFoodID() %>">

                <label for="name">Food Name:</label>
                <input id="name" type="text" name="name" value="<%= food.getName() %>" required>

                <label for="quantity">Quantity:</label>
                <input id="quantity" type="number" name="quantity" value="<%= food.getQuantity() %>" required>

                <button type="submit">Update</button>
            </form>
        </div>
    </main>
</body>
</html>

