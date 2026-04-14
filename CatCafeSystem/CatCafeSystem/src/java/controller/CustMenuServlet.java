package controller;

import dao.MenuDAO;
import model.Menu;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CustMenuServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Menu> menu = MenuDAO.getAllMenu();
            request.setAttribute("menu", menu);
        } catch (Exception e) {
            request.setAttribute("error", "Error loading menu: " + e.getMessage());
        }
        request.getRequestDispatcher("/ManageMenuCust.jsp?page=menu").forward(request, response);
    }
}
