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

public class EditFoodServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int foodID = Integer.parseInt(request.getParameter("foodID"));

        try {
            Connection conn = DBUtil.getConnection();
            CatFoodDAO dao = new CatFoodDAO(conn);
            CatFood food = dao.getCatFoodById(foodID); // We'll add this method

            request.setAttribute("food", food);
            RequestDispatcher dispatcher = request.getRequestDispatcher("editfood.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Edit Load Error: " + e.getMessage());
        }
    }
}
