<%-- 
    Document   : UpdateStaff
    Created on : 16 Jun 2025, 7:08:34 am
    Author     : Muhammad Syakil bin Mohd Zaidi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.model.Staff"%>
<%
    Staff staff = (Staff) request.getAttribute("staff");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Staff</title>
</head>
<body>
    <h1>Update Staff</h1>
    <form action="<%= request.getContextPath() %>/Admin/Dashboard/ManageStaff" method="post">
    <input type="hidden" name="action" value="updateStaffSubmit" />
    <input type="hidden" name="staffId" value="<%= staff.getStaffId() %>" />

    <label for="staffName">Name:</label>
    <input type="text" id="staffName" name="staffName" value="<%= staff.getStaffName() %>" required /><br/>

    <label for="staffStatus">Status:</label>
    <input type="text" id="staffStatus" name="staffStatus" value="<%= staff.getStaffStatus() %>" required /><br/>

    <label for="staffContact">Contact:</label>
    <input type="text" id="staffContact" name="staffContact" value="<%= staff.getStaffContact() %>" required /><br/>

    <button type="submit">Update</button>
</form>


    <form action="<%= request.getContextPath() %>/Admin/Dashboard/ManageStaff" method="get">
        <button type="submit">Cancel</button>
    </form>
</body>
</html>
