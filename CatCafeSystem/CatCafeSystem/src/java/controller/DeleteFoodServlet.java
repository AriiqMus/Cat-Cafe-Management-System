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
import util.DBUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

public class DeleteFoodServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int foodID = Integer.parseInt(request.getParameter("foodID"));

        try {
            Connection conn = DBUtil.getConnection();
            CatFoodDAO dao = new CatFoodDAO(conn);
            dao.deleteCatFood(foodID); // We’ll add this method below

            response.sendRedirect("CatFoodServlet");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Delete Error: " + e.getMessage());
        }
    }
}

