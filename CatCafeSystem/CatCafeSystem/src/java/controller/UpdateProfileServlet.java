package controller;

import dao.CustomersDAO;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class UpdateProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password"); // may be empty

        Connection conn = null;

        try {
            conn = util.DBUtil.getConnection();
            CustomersDAO dao = new CustomersDAO(conn);

            // If password is empty, don't update password
            String passwordToSave = (password == null || password.trim().isEmpty()) ? null : password;

            boolean updated = dao.updateCustomerPartial(customerId, email, phone, passwordToSave, username);

            if (updated) {
                request.setAttribute("message", "Profile updated successfully.");
            } else {
                request.setAttribute("message", "No changes were made.");
            }

            // Redirect back to profile
            response.sendRedirect("ProfileServlet");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error updating profile.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
