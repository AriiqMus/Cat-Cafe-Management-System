<%-- 
    Document   : SearchStaff
    Created on : 16 Jun 2025, 4:27:18 am
    Author     : Muhammad Syakil bin Mohd Zaidi
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search Staff</title>
</head>
<body>
    <h2>Search Staff</h2>

    <!-- Search by ID -->
    <form action="<%= request.getContextPath() %>/Admin/Dashboard/ManageStaff" method="get">
        <input type="hidden" name="action" value="searchStaffById" />
        <label for="staffId">Search by Staff ID:</label>
        <input type="text" name="staffId" required />
        <button type="submit">Search</button>
    </form>

    <!-- Search by Name -->
    <form action="<%= request.getContextPath() %>/Admin/Dashboard/ManageStaff" method="get">
        <input type="hidden" name="action" value="searchStaffByName" />
        <label for="staffName">Search by Name:</label>
        <input type="text" name="staffName" required />
        <button type="submit">Search</button>
    </form>
</body>
</html>