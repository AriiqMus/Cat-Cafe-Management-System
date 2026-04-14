<%-- 
    Document   : ManageBookingCust
    Created on : 14 Jun 2025, 2:24:02 pm
    Author     : sitif
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="model.CafeTable"%>
<%@page import="dao.CafeTableDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cat Diary Cafe Booking</title>
        <link rel="stylesheet" href="styleBook.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <jsp:include page="header.jsp">
            <jsp:param name="page" value="booking" />
        </jsp:include>

        <!-- Error Message -->
        <% if (request.getAttribute("error") != null) {%>
        <div class="alert error">
            <%= request.getAttribute("error")%>
        </div>
        <% }%>

        <!-- Booking Section -->
        <div class="book-box">
            <div class="book-header">
                <h1>Book Now!</h1>
            </div>

            <div class="book-form">
                <!-- Booking Form -->
                <div class="user-input">
                    <form method="post" action="CustBookingServlet" id="bookingForm">
                        <input type="hidden" name="action" value="selectDate">
                        <div class="form-group">
                            <label for="selectedDate">Select Date:</label>
                            <input type="date" name="selectedDate" id="selectedDate" class="form-control"
                                   min="<%= java.time.LocalDate.now()%>" required
                                   value="<%= request.getParameter("selectedDate") != null
                                           ? request.getParameter("selectedDate") : ""%>">
                        </div>
                        <button type="submit" class="btn">Check Availability</button>
                    </form>

                    <% if (request.getParameter("selectedDate") != null) {%>
                    <form method="post" action="CustBookingServlet" id="bookTableForm">
                        <input type="hidden" name="action" value="bookTable">
                        <input type="hidden" name="bookDate" value="<%= request.getParameter("selectedDate")%>">

                        <br>
                        <div class="form-group">
                            <label for="orderType">Order Type:</label>
                            <select name="orderType" id="orderType" class="form-control" required onchange="toggleTableSelection()">
                                <option value="DINE_IN">Dine-in</option>
                                <option value="TAKEAWAY">Takeaway</option>
                            </select>
                        </div>

                        <div id="tableSelection" class="form-group">
                            <label for="tableID">Select Table:</label>
                            <select name="tableID" id="tableID" class="form-control">
                                <%
                                    List<CafeTable> tables = (List<CafeTable>) request.getAttribute("tables");
                                    if (tables != null) {
                                        for (CafeTable table : tables) {
                                            if ("AVAILABLE".equalsIgnoreCase(table.getStatus())) {
                                %>
                                <option value="<%= table.getTableID()%>">
                                    <%= table.getTableNumber()%> (<%= table.getTableType()%>)
                                </option>
                                <%      }
                                        }
                                    }
                                %>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="custName">Your Name:</label>
                            <input type="text" name="custName" id="custName" class="form-control" required>
                        </div>

                        <button type="submit" class="btn">Confirm Booking</button>
                    </form>
                    <% } %>
                </div>

                <!-- Table Display -->
                <div class="table-container">
                    <div class="table-header">
                        <h1>Tables</h1>
                        <% if (request.getParameter("selectedDate") != null) {%>
                        <p>Availability for: <%= request.getParameter("selectedDate")%></p>
                        <% } %>
                    </div>
                    <div class="table-columns">
                        <!-- Single Tables -->
                        <div class="table-column">
                            <h2>Single Tables</h2>
                            <div class="table-display">
                                <%
                                    List<CafeTable> displayTables = (List<CafeTable>) request.getAttribute("tables");
                                    if (displayTables == null) {
                                        try {
                                            displayTables = CafeTableDAO.getAllTables();
                                        } catch (Exception e) {
                                            displayTables = new ArrayList<>();
                                        }
                                    }
                                    for (CafeTable table : displayTables) {
                                        if ("SINGLE".equalsIgnoreCase(table.getTableType())) {
                                            String statusClass = (request.getParameter("selectedDate") != null)
                                                    ? (table.getStatus().equalsIgnoreCase("AVAILABLE") ? "available" : "booked") : "";
                                %>
                                <div class="table-item">
                                    <div class="table-number"><%= table.getTableNumber()%></div>
                                    <div class="table-image-container">
                                        <div class="table-image"></div>
                                    </div>
                                    <% if (request.getParameter("selectedDate") != null) {%>
                                    <div class="table-status <%= statusClass%>"><%= table.getStatus()%></div> 
                                    <% } %>
                                </div>
                                <% }
                                    } %>
                            </div>
                        </div>

                        <!-- Double Tables -->
                        <div class="table-column">
                            <h2>Double Tables</h2>
                            <div class="table-display">
                                <%
                                    for (CafeTable table : displayTables) {
                                        if ("DOUBLE".equalsIgnoreCase(table.getTableType())) {
                                            String statusClass = (request.getParameter("selectedDate") != null)
                                                    ? (table.getStatus().equalsIgnoreCase("AVAILABLE") ? "available" : "booked") : "";
                                %>
                                <div class="table-item">
                                    <div class="table-number"><%= table.getTableNumber()%></div>
                                    <div class="table-image-container">
                                        <div class="table-image"></div>
                                        <div class="table-image"></div>
                                    </div>
                                    <% if (request.getParameter("selectedDate") != null) {%>
                                    <div class="table-status <%= statusClass%>"><%= table.getStatus()%></div> 
                                    <% } %>
                                </div>
                                <% }
                                    }%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>                  
        </div>

        <script>
            function toggleTableSelection() {
                const orderType = document.getElementById("orderType").value;
                const tableSelection = document.getElementById("tableSelection");

                if (orderType === "TAKEAWAY") {
                    tableSelection.style.display = "none";
                    document.getElementById("tableID").required = false;
                } else {
                    tableSelection.style.display = "flex";
                    document.getElementById("tableID").required = true;
                }
            }

            // Initialize on page load
            document.addEventListener("DOMContentLoaded", function () {
                toggleTableSelection();
            });
        </script>
    </body>
</html>