/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

/**
 *
 * @author sitif
 */
package controller;

import dao.CatFoodDAO;
import model.CatFood;
import util.DBUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

public class UpdateFoodServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int foodID = Integer.parseInt(request.getParameter("foodID"));
        String name = request.getParameter("name");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        try {
            Connection conn = DBUtil.getConnection();
            CatFoodDAO dao = new CatFoodDAO(conn);
            CatFood updatedFood = new CatFood(name, quantity);
            updatedFood.setFoodID(foodID);
            dao.updateCatFood(updatedFood); // We'll add this

            response.sendRedirect("CatFoodServlet");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Update Error: " + e.getMessage());
        }
    }
}
