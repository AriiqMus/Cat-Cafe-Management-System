/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
/**
 *
 * @author Muhammad Syakil bin Mohd Zaidi
 */
package controller;

import dao.CustomersDAO;
import model.Customers;
import util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;
import java.io.IOException;
import java.sql.*;
import java.text.SimpleDateFormat;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Read form data
            String name = request.getParameter("name");
            String birthdateStr = request.getParameter("birthdate");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // Convert birthdate
            java.util.Date utilDate = new SimpleDateFormat("yyyy-MM-dd").parse(birthdateStr);
            java.sql.Date sqlBirthdate = new java.sql.Date(utilDate.getTime());

            CustomersDAO dao = new CustomersDAO(DBUtil.getConnection());

            // Check if email exists
            if (dao.isEmailTaken(email)) {
                request.setAttribute("registerError", "Email is already registered.");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }

            // Check if username exists
            if (dao.isUsernameTaken(username)) {
                request.setAttribute("registerError", "Username is already taken.");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }

            // Insert using your existing DAO InsertResult (since you already have it)
            java.sql.Date sqlNow = new java.sql.Date(System.currentTimeMillis());
            dao.insertCustomer(name, sqlBirthdate, phone, email, password, username, sqlNow);

            // Success
            HttpSession session = request.getSession();
            session.setAttribute("Register", "Your Registration is successful!");
            response.sendRedirect("Login.jsp");

        } catch (Exception e) {
            e.printStackTrace();  // You already have this
            request.setAttribute("registerError", "Error: " + e.getMessage());
            request.getRequestDispatcher("Register.jsp").forward(request, response);
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("Register.jsp").forward(request, response);
    }
}
