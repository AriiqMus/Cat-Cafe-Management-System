/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

/**
 *
 * @author Muhammad Syakil bin Mohd Zaidi
 */

import dao.CustomersDAO;
import model.Customers;
import util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            CustomersDAO dao = new CustomersDAO(DBUtil.getConnection());
            Customers customer = dao.getCustomerByLogin(username, password);

            if (customer != null) {
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("customerId", customer.getCustomerId());
                session.setAttribute("customerName", customer.getCustomerName());
                session.setAttribute("customerObject", customer); // you can store full object if needed

                // Redirect to homepage/dashboard
                response.sendRedirect("HomepageServlet");
            } else {
                request.setAttribute("loginError", "Invalid username or password.");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("Login.jsp").forward(request, response);
    }
}
