package controller;

import model.Menu;
import dao.MenuDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;

public class CartServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        
        // Initialize cart if not exists
        List<Menu> cart = (List<Menu>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        // Check if request is AJAX (from menu page) or form submission (from cart page)
        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        
        try {
            if ("add".equals(action)) {
                // Add item to cart (from menu page)
                int menuId = Integer.parseInt(request.getParameter("menuId"));
                
                // Check if item exists
                boolean itemExists = false;
                for (Menu item : cart) {
                    if (item.getMenuID() == menuId) {
                        item.setQuantity(item.getQuantity() + 1);
                        itemExists = true;
                        break;
                    }
                }
                
                if (!itemExists) {
                    Menu menu = MenuDAO.getMenuById(menuId);
                    if (menu != null) {
                        menu.setQuantity(1);
                        cart.add(menu);
                    }
                }
                
                // Only return JSON for AJAX requests
                if (isAjax) {
                    response.setContentType("application/json");
                    PrintWriter out = response.getWriter();
                    JSONObject jsonResponse = new JSONObject();
                    jsonResponse.put("status", "success");
                    jsonResponse.put("cartSize", cart.size());
                    out.print(jsonResponse.toString());
                    return;
                }
            } 
            else if ("remove".equals(action)) {
                // Remove item (from cart page)
                int menuId = Integer.parseInt(request.getParameter("menuId"));
                cart.removeIf(item -> item.getMenuID() == menuId);
            } 
            else if ("update".equals(action)) {
                // Update quantity (from cart page)
                int menuId = Integer.parseInt(request.getParameter("menuId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                
                for (Menu item : cart) {
                    if (item.getMenuID() == menuId) {
                        item.setQuantity(quantity);
                        break;
                    }
                }
            }
            
            // For non-AJAX requests, redirect back to cart page
            response.sendRedirect("viewCart.jsp");
            
        } catch (NumberFormatException e) {
            if (isAjax) {
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Invalid number format");
                out.print(jsonResponse.toString());
            } else {
                request.setAttribute("error", "Invalid number format");
                request.getRequestDispatcher("viewCart.jsp").forward(request, response);
            }
        } catch (Exception e) {
            if (isAjax) {
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("status", "error");
                jsonResponse.put("message", e.getMessage());
                out.print(jsonResponse.toString());
            } else {
                request.setAttribute("error", e.getMessage());
                request.getRequestDispatcher("viewCart.jsp").forward(request, response);
            }
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Direct to view cart page
        response.sendRedirect("viewCart.jsp");
    }
}