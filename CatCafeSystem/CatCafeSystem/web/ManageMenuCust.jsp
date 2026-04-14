<%@page import="util.DBUtil"%>
<%@page import="model.Customers"%>
<%@page import="dao.MenuDAO"%>
<%@page import="model.Menu"%>
<%@page import="java.util.*"%>
<%@page import="dao.CustomersDAO"%>
<%@page import="java.sql.Connection"%>
<%@page import="model.Customers"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="styleMenu.css"/>
        <link rel="stylesheet" href="styleCart.css"/>
        <link rel="stylesheet" href="styles.css" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cat Diary Cafe Menu</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>

    <body>
        <%-- Customer session handling --%>

        <%
            Customers customers = null;
            String customerUsername = (String) session.getAttribute("customerUsername");
            if (customerUsername != null) {
                try {
                    Connection conn = DBUtil.getConnection();
                    CustomersDAO customersDAO = new CustomersDAO(conn);
                    customers = customersDAO.getCustomerByUsername(customerUsername);
                } catch (Exception e) {
                    session.removeAttribute("customerUsername");
                    e.printStackTrace();
                }
            }
        %>

        <!-- Navigation Bar -->
        <jsp:include page="header.jsp">
            <jsp:param name="page" value="menu" />
        </jsp:include>


        <!-- Main Menu Header -->
        <div class="menu-header">
            <h1>Cat Cafe Menu!</h1>
        </div>

        <%-- Error message display --%>
        <% if (request.getAttribute("error") != null) {%>
        <div class="alert error">
            <%= request.getAttribute("error")%>
        </div>
        <% } %>

        <%-- Menu display by category --%>
        <%
            List<Menu> displayMenu = (List<Menu>) request.getAttribute("menu");
            if (displayMenu == null) {
                try {
                    displayMenu = MenuDAO.getAllMenu();
                } catch (Exception e) {
                    displayMenu = new ArrayList<Menu>();
                }
            }

            // Group menu items by category (Java 7 compatible)
            Map<String, List<Menu>> menuByCategory = new HashMap<String, List<Menu>>();
            for (Menu menu : displayMenu) {
                String category = menu.getCategory();
                if (!menuByCategory.containsKey(category)) {
                    menuByCategory.put(category, new ArrayList<Menu>());
                }
                menuByCategory.get(category).add(menu);
            }

            // Define category display order and titles (Java 7 compatible)
            String[] categoryOrder = {"FOOD", "DESSERT", "BEVERAGE"};
            Map<String, String> categoryTitles = new HashMap<String, String>();
            categoryTitles.put("FOOD", "Our Food");
            categoryTitles.put("DESSERT", "Our Dessert");
            categoryTitles.put("BEVERAGE", "Our Beverage");
        %>

        <%-- Display each category --%>
        <% for (String category : categoryOrder) {
                if (menuByCategory.containsKey(category)) {
                    List<Menu> categoryItems = menuByCategory.get(category);
                    if (categoryItems != null && !categoryItems.isEmpty()) {%>
        <div class="category-container">
            <div class="category-section">
                <h2 class="category-title"><%= categoryTitles.get(category)%></h2>
                <div class="menu-container">
                    <% for (Menu menu : categoryItems) {%>
                    <div class="menu-card">
                        <div class="menu-image-container">
                            <img src="<%= menu.getImageUrl() != null ? menu.getImageUrl() : "images/default-food.jpg"%>" 
                                 alt="<%= menu.getName()%>" 
                                 class="menu-image"
                                 loading="lazy"
                                 onerror="this.onerror=null;this.src='images/default-food.jpg'"/>
                        </div>
                        <div class="menu-details">
                            <div class="menu-name"><%= menu.getName()%></div>
                            <div class="menu-price">RM <%= String.format("%.2f", menu.getPrice())%></div>
                            <div class="menu-status <%= menu.isIsAvailable() ? "available" : "unavailable"%>">
                                <%= menu.isIsAvailable() ? "Available" : "Unavailable"%>
                            </div>
                            <button class="add-to-cart" 
                                    data-menu-id="<%= menu.getMenuID()%>"
                                    <%= menu.isIsAvailable() ? "" : "disabled"%>>
                                <i class="fas fa-cart-plus"></i> Add to Cart
                            </button>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>
        <% }
                }
            }%>

        <script>
            $(document).ready(function () {
                // Handle Add to Cart button clicks
                $(".add-to-cart").click(function () {
                    var button = $(this);
                    var menuId = button.data("menu-id");

                    // Only proceed if button isn't disabled
                    if (button.prop("disabled"))
                        return;

                    // Disable button during request
                    button.prop("disabled", true);
                    button.html('<i class="fas fa-spinner fa-spin"></i> Adding...');

                    // Send AJAX request to add item
                    $.ajax({
                        type: "POST",
                        url: "CartServlet",
                        data: {
                            action: "add",
                            menuId: menuId
                        },
                        success: function (response) {
                            // Update cart count in navigation
                            $("#cartCount").text(response.cartSize);

                            // Show success feedback
                            button.html('<i class="fas fa-check"></i> Added!');
                            setTimeout(function () {
                                button.html('<i class="fas fa-cart-plus"></i> Add to Cart');
                                button.prop("disabled", false);
                            }, 1500);
                        },
                        error: function (xhr, status, error) {
                            // Show error feedback
                            button.html('<i class="fas fa-times"></i> Error');
                            setTimeout(function () {
                                button.html('<i class="fas fa-cart-plus"></i> Add to Cart');
                                button.prop("disabled", false);
                            }, 1500);

                            console.error("Error adding to cart:", error);
                        }
                    });
                });
            });
        </script>
    </body>
</html>