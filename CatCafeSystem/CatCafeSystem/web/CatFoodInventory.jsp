<%-- 
    Document   : CatFoodInventory
    Created on : 12 May 2025, 1:26:35 pm
    Author     : sitif
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.CatFood" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
    <head>
        <title>Cat Food Inventory</title>
        <!-- Font Awesome CDN -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="styles.css">
        <script src="script.js" defer></script>
    </head>


    <body>
        <jsp:include page="header.jsp">
            <jsp:param name="page" value="cat" />
        </jsp:include>


        <main>
            <h2>Cat Food Inventory</h2>
            <section class="inventory-container">
                <!-- Form to add new food -->
                <form action="CatFoodServlet" method="post" class="input-form">
                    <input type="text" name="name" placeholder="Enter Food Name" required>
                    <input type="number" name="quantity" placeholder="Enter Quantity" required>
                    <button type="submit" class="add-btn"><i class="fas fa-plus"></i></button>
                </form>

                <div class="search-form">
                    <form method="get" action="CatFoodServlet">
                        <input type="text" name="search" placeholder="🔍 Search cat food by name..." />
                        <button type="submit">Search</button>
                    </form>
                </div>

                <table>
                    <thead>
                        <tr>
                            <th>Cat Food</th>
                            <th>Quantity</th>
                            <th>Food ID</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<CatFood> catFoodList = (List<CatFood>) request.getAttribute("foodList");
                            if (catFoodList != null && !catFoodList.isEmpty()) {
                                for (CatFood food : catFoodList) {
                        %>
                        <tr>
                            <td><%= food.getName()%></td>
                            <td>x<%= food.getQuantity()%></td>
                            <td><%= food.getFoodID()%></td>
                            <td>
                                <button class="action-btn" onclick="showFoodDetails('<%= food.getName()%>', '<%= food.getQuantity()%>', '<%= food.getFoodID()%>')">
                                    <i class="fas fa-eye"></i>
                                </button>
                                <form action="DeleteFoodServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="foodID" value="<%= food.getFoodID()%>">
                                    <button type="submit" class="action-btn delete"><i class="fas fa-trash-alt"></i></button>
                                </form>

                                <form action="EditFoodServlet" method="get" style="display:inline;">
                                    <input type="hidden" name="foodID" value="<%= food.getFoodID()%>">
                                    <button type="submit" class="action-btn"><i class="fas fa-pen"></i></button>
                                </form>


                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="4" style="text-align:center;">No cat food available.</td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
            </section>
        </main>

        <!-- View Modal -->
        <div id="viewModal" class="modal">
            <div class="modal-content">
                <span class="close-btn">&times;</span>
                <h2>Cat Food Details</h2>
                <p><strong>Food Name:</strong> <span id="modalFoodName"></span></p>
                <p><strong>Quantity:</strong> <span id="modalQuantity"></span></p>
                <p><strong>Food ID:</strong> <span id="modalFoodID"></span></p>
            </div>
        </div>

        <!-- JS to handle modal -->
        <script>
            document.querySelectorAll(".delete").forEach(button => {
                button.addEventListener("click", function () {
                    const confirmDelete = confirm("Are you sure you want to delete this item?");
                    if (!confirmDelete)
                        event.preventDefault();
                });
            });

            window.onload = function () {
                const modal = document.getElementById('viewModal');
                const closeBtn = document.querySelector('.close-btn');

                window.showFoodDetails = function (foodName, quantity, foodID) {
                    document.getElementById('modalFoodName').innerText = foodName;
                    document.getElementById('modalQuantity').innerText = quantity;
                    document.getElementById('modalFoodID').innerText = foodID;
                    modal.style.display = "block";
                }

                closeBtn.onclick = function () {
                    modal.style.display = "none";
                }

                window.onclick = function (event) {
                    if (event.target === modal) {
                        modal.style.display = "none";
                    }
                }
            }
        </script>

        <footer>
            <p>&copy; 2025 Cat Diary Cafe. All rights reserved.</p>
        </footer>
    </body>
</html>
