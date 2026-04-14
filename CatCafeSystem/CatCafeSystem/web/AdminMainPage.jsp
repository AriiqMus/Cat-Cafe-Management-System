<%-- 
    Document   : AdminMainPage
    Created on : 26 May 2025, 8:45:38 pm
    Author     : sitif
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>Admin Dashboard</title>
        <link rel="stylesheet" href="styles.css" />
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #fffdf7;
                margin: 0;
                padding: 0;
            }

            .admin-greeting {
                text-align: center;
                padding: 30px 20px 10px;
            }

            .admin-greeting h2 {
                font-family: 'Castely', cursive;
                font-size: 2.6rem;
                color: #4b3621;
            }

            .admin-greeting p {
                color: #6e4f3a;
                font-size: 1rem;
                margin-top: 8px;
            }

            .dashboard-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
                gap: 30px;
                padding: 20px 50px;
            }

            .card {
                background-color: #fff8e1;
                border: 2px solid #4b3621;
                border-radius: 15px;
                padding: 25px;
                text-align: center;
                transition: all 0.3s ease;
            }

            .card:hover {
                background-color: #ffdd95;
                transform: scale(1.03);
            }

            .card h3 {
                font-size: 1.5rem;
                color: #4b3621;
                margin-bottom: 10px;
            }

            .card p {
                color: #6e4f3a;
                margin-bottom: 15px;
            }

            .card a, .card button {
                text-decoration: none;
                padding: 10px 20px;
                font-size: 1rem;
                border: 2px solid #4b3621;
                border-radius: 12px;
                background-color: #f0eacb;
                color: #4b3621;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .card a:hover, .card button:hover {
                background-color: #ffe2a8;
            }

            .stats-row {
                display: flex;
                justify-content: center;
                gap: 20px;
                margin: 20px 0 40px;
            }

            .stat-card {
                background-color: #f0eacb;
                border: 2px solid #4b3621;
                border-radius: 15px;
                padding: 20px;
                width: 150px;
                text-align: center;
            }

            .stat-card h4 {
                color: #4b3621;
                margin-bottom: 10px;
            }

            /* Modal */
            .modal {
                display: none;
                position: fixed;
                z-index: 100;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.4);
            }

            .modal-content {
                background-color: #fff8e1;
                margin: 10% auto;
                padding: 30px;
                border: 2px solid #4b3621;
                width: 70%;
                max-width: 500px;
                border-radius: 20px;
                text-align: center;
            }

            .modal h3 {
                font-size: 1.8rem;
                color: #4b3621;
                margin-bottom: 30px;
            }

            .modal a {
                display: inline-block;
                margin: 10px;
            }

            .close-btn {
                float: right;
                font-size: 24px;
                font-weight: bold;
                color: #4b3621;
                cursor: pointer;
            }

            .close-btn:hover {
                color: red;
            }
        </style>
    </head>
    <body>

        <jsp:include page="header.jsp">
            <jsp:param name="page" value="home" />
        </jsp:include>

        <div class="admin-greeting">
            <h2>Welcome, Admin! 🐾</h2>
            <p>Manage your café operations below</p>
        </div>

        <!-- Optional stats preview (can be made dynamic later) -->
        <div class="stats-row">
            <div class="stat-card">
                <h4>🐱 Cats</h4>
                <p>5 profiles</p>
            </div>
            <div class="stat-card">
                <h4>🍽️ Food</h4>
                <p>10 items</p>
            </div>
            <div class="stat-card">
                <h4>👩‍💼 Staff</h4>
                <p>3 users</p>
            </div>
        </div>

        <!-- Main admin action cards -->
        <div class="dashboard-grid">
            <div class="card">
                <h3>Manage Staff</h3>
                <p>View, add or remove staff accounts</p>
                <a href="ManageStaffServlet">Go to Staff</a>
            </div>
            <div class="card">
                <h3>Manage Menu</h3>
                <p>Update food & drinks menu</p>
                <a href="ManageMenuStaff.jsp">Go to Menu</a>
            </div>
            <div class="card">
                <h3>Cat Items</h3>
                <p>Manage cat profiles and food</p>
                <button onclick="openModal()">Open</button>
            </div>
        </div>

        <!-- Modal -->
        <div id="catModal" class="modal">
            <div class="modal-content">
                <span class="close-btn" onclick="closeModal()">&times;</span>
                <h3>Manage Cat Items</h3>
                <a href="CatProfileServlet">🐱 Cat Profiles</a> <!-- opens admin list -->
                <a href="CatFoodServlet" class="btn">🍽️ Cat Food Inventory</a>
            </div>
        </div>

        <script>
            function openModal() {
                document.getElementById("catModal").style.display = "block";
            }

            function closeModal() {
                document.getElementById("catModal").style.display = "none";
            }

            window.onclick = function (event) {
                const modal = document.getElementById("catModal");
                if (event.target === modal) {
                    modal.style.display = "none";
                }
            };
        </script>
    </body>
</html>
