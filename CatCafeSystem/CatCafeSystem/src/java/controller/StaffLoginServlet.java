package controller;

import util.DBUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class StaffLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String staffId = request.getParameter("staffId");
        String password = request.getParameter("password");
        String selectedRole = request.getParameter("role"); // get role from form

        try ( Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM staff WHERE staff_id = ? AND password = ? AND role = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, staffId);
            stmt.setString(2, password);
            stmt.setString(3, selectedRole);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // login success
                HttpSession session = request.getSession();
                session.setAttribute("staffId", staffId);
                session.setAttribute("role", selectedRole);

                if ("admin".equalsIgnoreCase(selectedRole)) {
                    response.sendRedirect(request.getContextPath() + "/AdminMainPage.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/StaffMainPage.jsp");
                }
            } else {
                response.sendRedirect("StaffLoginPage.jsp?error=true");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
