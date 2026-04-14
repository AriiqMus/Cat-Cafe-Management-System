<%-- 
    Document   : SeeAllStaff
    Created on : 16 Jun 2025, 4:28:12 am
    Author     : Muhammad Syakil bin Mohd Zaidi
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.model.Staff" %>
<html>
<head>
    <title>All Staff</title>
</head>
<body>
    <h2>Staff List</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Status</th>
            <th>Contact</th>
            <th>Actions</th>
        </tr>
        <%
            List<Staff> staffList = (List<Staff>) request.getAttribute("staffList");
            if (staffList != null) {
                for (Staff s : staffList) {
        %>
        <tr>
            <td><%= s.getStaffId() %></td>
            <td><%= s.getStaffName() %></td>
            <td><%= s.getStaffStatus() %></td>
            <td><%= s.getStaffContact() %></td>
            <td>
                <form action="<%= request.getContextPath() %>/Admin/Dashboard/ManageStaff" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="deleteStaff" />
                    <input type="hidden" name="staffId" value="<%= s.getStaffId() %>" />
                    <button type="submit">Delete</button>
                </form>
                <form action="<%= request.getContextPath() %>/Admin/Dashboard/ManageStaff" method="get" style="display:inline;">
                    <input type="hidden" name="action" value="editStaff" />
                    <input type="hidden" name="staffId" value="<%= s.getStaffId() %>" />
                    <button type="submit">Edit</button>
                </form>
            </td>
        </tr>
        <%
                }
            }
        %>
    </table>
</body>
</html>
