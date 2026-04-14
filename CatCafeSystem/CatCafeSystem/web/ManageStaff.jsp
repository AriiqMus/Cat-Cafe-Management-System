<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Staff" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Manage Staff</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
        <style>
            body {
                margin: 0;
                font-family: 'Poppins', sans-serif;
                background-color: #fcd56a;
                color: #000;
            }
            .container {
                width: 80%;
                margin: 50px auto;
                background-color: #f0eacb;
                border: 3px solid black;
                border-radius: 30px;
                padding: 30px;
                text-align: center;
            }
            h2 {
                font-family: 'Castely', cursive;
                font-size: 2.5rem;
                margin-bottom: 20px;
                color: #4b3621;
            }
            .search-form {
                display: flex;
                justify-content: center;
                margin: 30px 0;
            }
            .search-form input {
                width: 300px;
                padding: 12px 15px;
                border-radius: 20px 0 0 20px;
                border: 2px solid #4b3621;
                font-size: 16px;
                background-color: #fffaf0;
                outline: none;
            }
            .search-form button {
                padding: 12px 20px;
                border-radius: 0 20px 20px 0;
                border: 2px solid #4b3621;
                background-color: #ffdd95;
                color: #4b3621;
                font-weight: bold;
                font-size: 16px;
                cursor: pointer;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                font-size: 16px;
            }
            th, td {
                border: 2px solid black;
                padding: 12px;
                text-align: center;
            }
            th {
                background-color: #fff8e1;
                color: #4b3621;
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

        <div class="container">
            <h2>Manage Staff 🐾</h2>

            <form class="search-form" method="get" action="ManageStaffServlet">
                <input type="text" name="search" placeholder="Search staff by name or ID..." value="<%= request.getParameter("search") != null ? request.getParameter("search") : ""%>"/>
                <button type="submit">Search</button>
            </form>

            <table>
                <tr>
                    <th>Staff ID</th>
                    <th>Name</th>
                    <th>Username</th>
                    <th>Role</th>
                </tr>
                <%
                    List<Staff> staffList = (List<Staff>) request.getAttribute("staffList");
                    if (staffList != null && !staffList.isEmpty()) {
                        for (Staff s : staffList) {
                %>
                <tr>
                    <td><%= s.getStaffId()%></td>
                    <td><%= s.getName()%></td>
                    <td><%= s.getUsername()%></td>
                    <td><%= s.getRole()%></td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr><td colspan="4">No staff found.</td></tr>
                <% }%>
            </table>
        </div>

        <a href="AdminMainPage.jsp" class="back-button">← Back to Profiles</a>

    </body>
</html>
