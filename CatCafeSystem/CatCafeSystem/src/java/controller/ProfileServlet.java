package controller;

import dao.CustomersDAO;
import model.Customers;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import util.DBUtil;

public class ProfileServlet extends HttpServlet {

    private CustomersDAO customersDAO;

    @Override
    public void init() throws ServletException {
        try {
            customersDAO = new CustomersDAO(DBUtil.getConnection());
        } catch (Exception e) {
            throw new ServletException("Database connection failed", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("username") : null;

        if (username == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        try {
            Customers customer = customersDAO.getCustomerByUsername(username);
            if (customer == null) {
                request.setAttribute("error", "Customer not found.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }

            request.setAttribute("customer", customer);

            String action = request.getParameter("action");
            if ("update".equals(action)) {
                request.getRequestDispatcher("customerEditProfile.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("Profile.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String currentUsername = (session != null) ? (String) session.getAttribute("username") : null;

        if (currentUsername == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String newEmail = request.getParameter("email");
        String newPhone = request.getParameter("phone");
        String newPassword = request.getParameter("password");
        String newUsername = request.getParameter("newUsername");

        try {
            int customerId = customersDAO.getCustomerIdByUsername(currentUsername);

            boolean updated = customersDAO.updateCustomerPartial(customerId, newEmail, newPhone, newPassword, newUsername);

            if (updated) {
                if (newUsername != null && !newUsername.trim().isEmpty()) {
                    session.setAttribute("username", newUsername);
                }
                request.setAttribute("success", "Profile updated successfully!");

            } else {
                request.setAttribute("error", "No fields were updated.");
            }

            Customers customer = customersDAO.getCustomerByUsername(
                (newUsername != null && !newUsername.trim().isEmpty()) ? newUsername : currentUsername
            );
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("Profile.jsp").forward(request, response);

        } catch (SQLIntegrityConstraintViolationException e) {
            request.setAttribute("error", "Username or email already taken.");
            Customers customer = null;
            try {
                customer = customersDAO.getCustomerByUsername(currentUsername);
            } catch (SQLException ex) {
                Logger.getLogger(ProfileServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("customerEditProfile.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
