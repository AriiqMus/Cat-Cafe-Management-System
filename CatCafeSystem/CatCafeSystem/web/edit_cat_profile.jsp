<%-- 
    Document   : edit_cat_profile
    Created on : 16 Jun 2025, 3:11:39 pm
    Author     : sitif
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.CatProfile" %>
<%
    CatProfile cat = (CatProfile) request.getAttribute("cat");
%>
<html>
    <head>
        <title>Edit Cat Profile</title>
        <link rel="stylesheet" href="styles.css">
        <style>
            .edit-container {
                max-width: 600px;
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

            form label {
                display: block;
                margin-top: 15px;
                font-weight: 600;
                font-size: 1.1rem;
            }

            form input[type="text"],
            form input[type="number"],
            form select {
                width: 100%;
                padding: 10px;
                font-size: 1rem;
                border: 2px solid black;
                border-radius: 8px;
                box-sizing: border-box;
                margin-top: 5px;
            }

            form button {
                margin-top: 30px;
                background-color: #a3d977;
                color: #4b3621;
                border: none;
                padding: 12px 25px;
                font-size: 1.1rem;
                font-weight: bold;
                border-radius: 12px;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.2s ease;
                display: block;
                width: 100%;
            }

            form button:hover {
                background-color: #90c15c;
                transform: scale(1.03);
            }

            footer {
                text-align: center;
                padding: 20px;
                margin-top: 50px;
                background-color: #fff8dc;
                font-family: 'Poppins', sans-serif;
                color: #4b3621;
                border-top: 2px solid #e3d8b3;
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


        <main>
            <div class="edit-container">
                <h2>Edit Cat Profile</h2>
                <% if (cat != null) {%>
                <form action="EditCatProfileServlet" method="post">
                    <input type="hidden" name="catId" value="<%= cat.getCatId()%>" />

                    <label for="name">Name:</label>
                    <input type="text" name="name" id="name" value="<%= cat.getName()%>" required />

                    <label for="breed">Breed:</label>
                    <input type="text" name="breed" id="breed" value="<%= cat.getBreed()%>" required />

                    <label for="age">Age:</label>
                    <input type="number" name="age" id="age" value="<%= cat.getAge()%>" required min="0" />

                    <label for="gender">Gender:</label>
                    <select name="gender" id="gender" required>
                        <option value="Male" <%= cat.getGender().equals("Male") ? "selected" : ""%>>Male</option>
                        <option value="Female" <%= cat.getGender().equals("Female") ? "selected" : ""%>>Female</option>
                    </select>

                    <label for="healthStatus">Health Status:</label>
                    <input type="text" name="healthStatus" id="healthStatus" value="<%= cat.getHealthStatus()%>" required />

                    <label for="image">Image URL:</label>
                    <input type="text" name="image" id="image" value="<%= cat.getImage()%>" required />

                    <button type="submit">Update Profile</button>
                </form>
                <% } else { %>
                <p style="text-align:center; color:red;">Cat profile not found.</p>
                <% }%>
            </div>
            <a href="CatProfileServlet" class="back-button">← Back to Profiles</a>

        </main>

        <footer>
            <p>&copy; 2025 Cat Diary Cafe. All rights reserved.</p>
        </footer>
    </body>
</html>
