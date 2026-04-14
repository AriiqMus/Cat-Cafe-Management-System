package controller;

/**
 *
 * @author sitif
 */
import dao.CatFoodDAO;
import model.CatFood;
import util.DBUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

public class CatFoodServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetch the name and quantity of the new cat food item from the form
        String name = request.getParameter("name");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Create a new CatFood object
        CatFood newFood = new CatFood(name, quantity);

        try {
            // Get database connection
            Connection conn = DBUtil.getConnection();
            CatFoodDAO dao = new CatFoodDAO(conn);

            // Add the new cat food to the database
            dao.addCatFood(newFood);

            // Redirect back to the list of cat food items (or any other page)
            response.sendRedirect("CatFoodServlet");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Connection conn = DBUtil.getConnection();
            CatFoodDAO dao = new CatFoodDAO(conn);

            String search = request.getParameter("search");
            List<CatFood> foodList;

            if (search != null && !search.trim().isEmpty()) {
                foodList = dao.searchCatFoodByName(search.trim());
            } else {
                foodList = dao.getAllCatFoods();
            }

            request.setAttribute("foodList", foodList);
            RequestDispatcher dispatcher = request.getRequestDispatcher("CatFoodInventory.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }

}
