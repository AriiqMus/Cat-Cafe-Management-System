<%-- 
    Document   : cat_profiles_admin
    Created on : 16 Jun 2025, 3:24:42?pm
    Author     : sitif
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.CatProfile" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    List<CatProfile> catList = (List<CatProfile>) request.getAttribute("catList");
%>
<html>
    <head>
        <title>Manage Cat Profiles</title>
        <link rel="stylesheet" href="styles.css">
        <style>
            .edit-button {
                background-color: #a3d977;
                color: #4b3621;
                text-decoration: none;
                padding: 10px 20px;
                font-size: 1rem;
                font-weight: 600;
                border-radius: 25px;
                border: 2px solid #4b3621;
                transition: all 0.3s ease;
                font-family: 'Poppins', sans-serif;
                display: inline-block;
                box-shadow: 2px 2px 5px rgba(0,0,0,0.1);
            }

            .edit-button:hover {
                background-color: #90c15c;
                transform: scale(1.05);
            }

            table {
                width: 90%;
                margin: 30px auto;
                border-collapse: collapse;
                background-color: #fff8dc;
                font-family: 'Poppins', sans-serif;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            }

            th, td {
                padding: 15px;
                text-align: center;
                border-bottom: 1px solid #e0d9b5;
                font-size: 1rem;
            }

            th {
                background-color: #f6e6b4;
                color: #4b3621;
                font-size: 1.1rem;
            }

            h2 {
                text-align: center;
                margin-top: 40px;
                font-family: 'Castely', cursive;
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
        <jsp:include page="header.jsp">
            <jsp:param name="page" value="editCat" />
        </jsp:include>


        <h2>Cat Profiles (Admin)</h2>
        <table>
            <tr>
                <th>Name</th>
                <th>Breed</th>
                <th>Age</th>
                <th>Gender</th>
                <th>Health</th>
                <th>Action</th>
            </tr>
            <c:forEach var="cat" items="${catList}">
                <tr>
                    <td>${cat.name}</td>
                    <td>${cat.breed}</td>
                    <td>${cat.age}</td>
                    <td>${cat.gender}</td>
                    <td>${cat.healthStatus}</td>
                    <td>
                        <a class="edit-button" href="EditCatProfileServlet?catId=${cat.catId}">✏️ Edit</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <a href="AdminMainPage.jsp" class="back-button">← Back to Admin Home</a>

    </body>
</html>
