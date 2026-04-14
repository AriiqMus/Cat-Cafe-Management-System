<%@page import="java.util.List"%>
<%@page import="model.Booking"%>
<%@page import="java.sql.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Staff Booking Management</title>
    <style>
        /* ===== BASE STYLES ===== */
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background-color: #fcd56a;
            color: #000;
        }

        /* ===== NAVIGATION BAR ===== */
        .nav {
            background-color: #f0eacb;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 30px;
        }

        .nav h2 {
            margin: 0;
        }

        .nav ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex;
        }

        .nav li {
            margin-left: 20px;
        }

        .nav a {
            display: block;
            padding: 14px 16px;
            text-decoration: none;
            color: black;
        }

        .nav a:hover {
            color: #fada7a;
        }

        .nav a.active {
            color: #fcd56a;
            font-weight: bold;
        }

        .user-icon {
            margin-left: 10px;
        }
        table { 
            border-collapse: collapse; width: 100%; 
        }
        th, td { 
            border: 1px solid #ddd; padding: 8px; text-align: left; 
        }
        th { 
            background-color: #f2f2f2; 
        }
        .error { 
            color: red; 
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <div class="nav">
        <h2>Cat Diary Cafe</h2>
        <ul>
            <li><a href="Home.jsp">Home</a></li>
            <li><a href="StaffBookingServlet" class="active">Booking</a></li>
            <li><a href="StaffMenuServlet">Menu</a></li>
            <li><a href="Cat.jsp">Cat</a></li>
            <li><a href="Profile.jsp"><i class="fa-solid fa-user user-icon"></i></a></li>
        </ul>
    </div>
    <h1>Booking Management</h1>
    
    <% if (request.getAttribute("error") != null) { %>
        <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>
    
    <!-- Date Selection Form -->
    <form method="post" action="StaffBookingServlet">
        <input type="hidden" name="action" value="selectDate">
        <label for="selectedDate">Select Date:</label>
        <input type="date" name="selectedDate" id="selectedDate" required 
               value="<%= request.getParameter("selectedDate") != null ? 
                       request.getParameter("selectedDate") : "" %>">
        <button type="submit">View Bookings</button>
    </form>
    
    <% if (request.getParameter("selectedDate") != null) { %>
        <h2>Bookings for <%= request.getParameter("selectedDate") %></h2>
        
        <!-- Booking Management Table -->
        <table>
            <tr>
                <th>Booking ID</th>
                <th>Customer ID</th>
                <th>Customer Name</th>
                <th>Table Number</th>
                <th>Type</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            <%
                List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
                if (bookings != null && !bookings.isEmpty()) {
                    for (Booking booking : bookings) {
            %>
            <tr>
                <td><%= booking.getBookingID() %></td>
                <td><%= booking.getCustID() %></td>
                <td><%= booking.getCustName() %></td>
                <td><%= booking.getTableID() != null ? booking.getTableID() : "N/A" %></td>
                <td><%= booking.getBookingType() %></td>
                <td><%= booking.getStatus() %></td>
                <td>
                    <form method="post" action="StaffBookingServlet" style="display:inline;">
                        <input type="hidden" name="action" value="updateStatus">
                        <input type="hidden" name="bookingID" value="<%= booking.getBookingID() %>">
                        <input type="hidden" name="selectedDate" value="<%= request.getParameter("selectedDate") %>">
                        <select name="status">
                            <option value="CONFIRMED" <%= "CONFIRMED".equals(booking.getStatus()) ? "selected" : "" %>>Confirmed</option>
                            <option value="CANCELLED" <%= "CANCELLED".equals(booking.getStatus()) ? "selected" : "" %>>Cancelled</option>
                            <option value="COMPLETED" <%= "COMPLETED".equals(booking.getStatus()) ? "selected" : "" %>>Completed</option>
                        </select>
                        <button type="submit">Update</button>
                    </form>
                </td>
            </tr>
            <% 
                    }
                } else {
            %>
            <tr>
                <td colspan="6">No bookings found for this date</td>
            </tr>
            <% } %>
        </table>
    <% } %>
</body>
</html>