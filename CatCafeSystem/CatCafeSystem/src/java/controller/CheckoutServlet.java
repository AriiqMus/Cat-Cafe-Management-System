package controller;

import dao.OrderDAO;
import model.Order;
import model.OrderItem;
import model.Menu;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CheckoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Menu> cart = (List<Menu>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("ManageMenuCust.jsp");
            return;
        }

        // Calculate total
        double total = cart.stream()
                .mapToDouble(item -> item.getPrice() * item.getQuantity())
                .sum();

        // Set attributes for checkout.jsp
        request.setAttribute("cartItems", cart);
        request.setAttribute("total", total);

        // Forward to checkout.jsp
        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
    }

    // Handle POST requests (process checkout)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Menu> cart = (List<Menu>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("ManageMenuCust.jsp");
            return;
        }

        try {
            Integer customerId = (Integer) session.getAttribute("customerId");
            if (customerId == null) {
                throw new Exception("Customer not logged in");
            }

            Order order = new Order();
            order.setCustomerId(customerId);

            String orderType = request.getParameter("orderType");
            if (orderType == null) {
                // Try to get from session (set by booking)
                orderType = (String) session.getAttribute("orderType");
            }
            if (orderType == null) {
                // Fallback default
                orderType = "TAKEAWAY";
            }
            order.setOrderType(orderType);

            order.setStatus("PAID");
            order.setPaymentMethod(request.getParameter("paymentMethod"));

            double total = cart.stream()
                .mapToDouble(item -> item.getPrice() * item.getQuantity())
                .sum();
            order.setTotalAmount(total);

            if ("DINE_IN".equals(orderType)) {
                Integer tableID = (Integer) session.getAttribute("tableID");
                if (tableID != null) {
                    order.setTableID(tableID);
                }
            }

            int orderID = OrderDAO.createOrder(order);

            for (Menu item : cart) {
                OrderItem orderItem = new OrderItem();
                orderItem.setOrderID(orderID);
                orderItem.setMenuID(item.getMenuID());
                orderItem.setQuantity(item.getQuantity());
                orderItem.setPrice(item.getPrice());
                OrderDAO.addOrderItem(orderItem);
            }

            session.removeAttribute("cart");
            session.setAttribute("orderNumber", "ORD-" + orderID);
            session.setAttribute("paymentMethod", order.getPaymentMethod());

            response.sendRedirect("paymentSuccess.jsp");

        } catch (Exception e) {
            request.setAttribute("error", "Checkout failed: " + e.getMessage());

            // Re-populate cart data for the checkout page
            double total = cart.stream()
                .mapToDouble(item -> item.getPrice() * item.getQuantity())
                .sum();
            request.setAttribute("cartItems", cart);
            request.setAttribute("total", total);

            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
        }
    }
}
