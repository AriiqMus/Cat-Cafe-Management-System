/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
/**
 *
 * @author sitif
 */
package controller;

import dao.CatProfileDao;
import model.CatProfile;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

public class EditCatProfileServlet extends HttpServlet {

    private Connection conn;

    public void init() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/catcafedb2", "root", "admin");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // --- POST: handle form submission ---
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int catId = Integer.parseInt(request.getParameter("catId"));
        String name = request.getParameter("name");
        String breed = request.getParameter("breed");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String healthStatus = request.getParameter("healthStatus");
        String image = request.getParameter("image");

        CatProfile updatedCat = new CatProfile();
        updatedCat.setCatId(catId);
        updatedCat.setName(name);
        updatedCat.setBreed(breed);
        updatedCat.setAge(age);
        updatedCat.setGender(gender);
        updatedCat.setHealthStatus(healthStatus);
        updatedCat.setImage(image);

        CatProfileDao dao = new CatProfileDao(conn);
        try {
            dao.updateCatProfile(updatedCat);
            response.sendRedirect("CatProfileServlet"); // redirect to updated list
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // --- GET: show form with current cat data ---
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = (session != null && session.getAttribute("role") != null)
                ? (String) session.getAttribute("role") : "guest";

        if (!"Admin".equalsIgnoreCase(role) && !"Staff".equalsIgnoreCase(role)) {
            response.sendRedirect("unauthorised.jsp");
            return;
        }

        int catId = Integer.parseInt(request.getParameter("catId"));
        CatProfileDao dao = new CatProfileDao(conn);
        try {
            CatProfile cat = dao.getCatById(catId);
            request.setAttribute("cat", cat);
            RequestDispatcher dispatcher = request.getRequestDispatcher("edit_cat_profile.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
