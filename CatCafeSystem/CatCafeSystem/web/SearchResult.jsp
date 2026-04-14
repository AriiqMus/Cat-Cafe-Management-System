<%-- 
    Document   : SearchResult
    Created on : 16 Jun 2025, 7:08:56 am
    Author     : Muhammad Syakil bin Mohd Zaidi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.model.Staff"%>
<%
    List<Staff> result = (List<Staff>) request.getAttribute("result");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Search Results</title>
</head>
<body>
    <h1>Search Results</h1>

    <% if (result == null || result.isEmpty()) { %>
        <p>No matching staff found.</p>
    <% } else { %>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Status</th>
                <th>Contact</th>
                <th>Actions</th>
            </tr>
            <% for (Staff staff : result) { %>
                <tr>
                    <td><%= staff.getStaffId() %></td>
                    <td><%= staff.getStaffName() %></td>
                    <td><%= staff.getStaffStatus() %></td>
                    <td><%= staff.getStaffContact() %></td>
                    <td>
                        <form action="<%= request.getContextPath() %>/Admin/Dashboard/ManageStaff" method="get" style="display:inline;">
                            <input type="hidden" name="action" value="updateStaff" />
                            <input type="hidden" name="staffId" value="<%= staff.getStaffId() %>" />

                            <button type="submit">Update</button>
                        </form>
                        <form action="<%= request.getContextPath() %>/Admin/Dashboard/ManageStaff" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="deleteStaff" />
                            <input type="hidden" name="staffId" value="<%= staff.getStaffId() %>" />
                            <button type="submit" onclick="return confirm('Are you sure you want to delete this staff?');">Delete</button>
                        </form>
                    </td>
                </tr>
            <% } %>
        </table>
    <% } %>

    <br/>
    <form action="<%= request.getContextPath() %>/Admin/Dashboard/ManageStaff" method="get">
        <button type="submit">Back</button>
    </form>
</body>
</html>
