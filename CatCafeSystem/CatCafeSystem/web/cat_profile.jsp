<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.CatProfile" %>
<%
    CatProfile cat = (CatProfile) request.getAttribute("cat");
%>
<html>
    <head>
        <title>Cat Profile</title>
        <link rel="stylesheet" href="styles.css">
        <link rel="stylesheet" href="cat.css">
    </head>
    <body>
        <jsp:include page="header.jsp">
            <jsp:param name="page" value="cat" />
        </jsp:include>

        <div class="profile-container">
            <% if (cat != null) {%>
            <div class="cat-card">
                <img src="<%= cat.getImage()%>" class="profile-img" />
                <div class="cat-info">
                    <h2>Name: <%= cat.getName()%></h2>
                    <p>Breed: <%= cat.getBreed()%></p>
                    <p>Age: <%= cat.getAge()%></p>
                    <p>Gender: <%= cat.getGender()%></p>
                    <p>Health Status: <%= cat.getHealthStatus()%></p>
                    <a href="CatProfileServlet">← Back to All Cats</a>
                </div>
            </div>
            <% } else { %>
            <p>No cat profile found.</p>
            <% }%>
        </div>

        <footer>
            <p>&copy; 2025 Cat Diary Cafe. All rights reserved.</p>
        </footer>
    </body>
</html>
