package controller;

import dao.StaffOrderDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateOrderStatusServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int orderID = Integer.parseInt(request.getParameter("orderID"));
        String newStatus = request.getParameter("status");
        
        try {
            boolean success = StaffOrderDAO.updateOrderStatus(orderID, newStatus);
            if (success) {
                String referer = request.getHeader("Referer");
                response.sendRedirect(referer != null ? referer : "staffOrderList.jsp");
            } else {
                response.sendRedirect("staffOrderList.jsp?error=Failed to update order status");
            }
        } catch (SQLException e) {
            response.sendRedirect("staffOrderList.jsp?error=" + e.getMessage());
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UpdateOrderStatusServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}