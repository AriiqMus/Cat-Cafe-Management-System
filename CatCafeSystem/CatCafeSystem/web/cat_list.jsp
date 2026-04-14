<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.CatProfile" %>
<%
    List<CatProfile> catList = (List<CatProfile>) request.getAttribute("catList");
%>
<html>
    <head>
        <title>Our Lovely Cats</title>
        <link href="https://fonts.googleapis.com/css2?family=Cinzel+Decorative:wght@700&family=Poppins&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background: #FFF8EF;
                color: #3f2e1e;
                margin: 0;
                padding: 0;
            }
           
            main {
                padding: 2rem;
                max-width: 1200px;
                margin: 0 auto;
            }
            .intro-text h2 {
                font-family: 'Cinzel Decorative', cursive;
                font-size: 2.8rem;
                color: #3f2e1e;
                margin-bottom: 1rem;
            }
            .intro-text p {
                font-size: 1.2rem;
                color: #6B4C3B;
                margin-bottom: 3rem;
            }
            .cat-container {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
                gap: 2rem;
            }
            .cat-box {
                background: #FAF3E3;
                border: 3px solid #B8895A;
                border-radius: 20px;
                box-shadow: 0 8px 20px rgba(0,0,0,0.1);
                text-align: center;
                transition: transform 0.3s, box-shadow 0.3s;
                padding: 1.2rem;
            }
            .cat-box:hover {
                transform: translateY(-8px);
                box-shadow: 0 10px 25px rgba(0,0,0,0.15);
            }
            .cat-img {
                width: 100%;
                height: 250px;
                object-fit: cover;
                border-radius: 15px;
                margin-bottom: 1rem;
            }
            .cat-box h3 {
                font-family: 'Cinzel Decorative', cursive;
                font-size: 1.8rem;
                margin-bottom: 0.5rem;
                color: #3F2E1E;
            }
            .cat-box p {
                margin: 0.3rem 0;
                color: #6B4C3B;
            }
            .cat-box a {
                display: inline-block;
                margin-top: 1rem;
                padding: 0.6rem 1.2rem;
                background: #B8895A;
                color: white;
                text-decoration: none;
                border-radius: 12px;
                transition: background 0.3s;
                font-weight: bold;
            }
            .cat-box a:hover {
                background: #8F6B42;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp">
            <jsp:param name="page" value="cat" />
        </jsp:include>

        <main>
            <section class="intro-text" style="text-align: center;">
                <h2>🐾 Take a Look at Our Adorable Cats! 🏰</h2>
                <p>Welcome to our castle of cuddles! Each feline has their own royal charm, waiting to be discovered.</p>
            </section>

            <div class="cat-container">
                <% if (catList != null && !catList.isEmpty()) {
                    for (CatProfile cat : catList) { %>
                <div class="cat-box">
                    <img src="<%= cat.getImage() %>" alt="Cat Image" class="cat-img" />
                    <h3><%= cat.getName() %></h3>
                    <p>Breed: <%= cat.getBreed() %></p>
                    <p>Age: <%= cat.getAge() %> years</p>
                    <p>Gender: <%= cat.getGender() %></p>
                    <a href="CatProfileServlet?id=<%= cat.getCatId() %>">View Details</a>
                </div>
                <% } 
                } else { %>
                <p style="text-align:center; font-size: 1.2rem;">No cat profiles found.</p>
                <% } %>
            </div>
        </main>

        <footer>
            &copy; 2025 Cat Diary Cafe. All rights reserved.
        </footer>
    </body>
</html>
