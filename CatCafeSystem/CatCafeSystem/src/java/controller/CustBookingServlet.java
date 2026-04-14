package controller;

import dao.BookingDAO;
import dao.CafeTableDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CafeTable;

/**
 *
 * @author Ariiq
 */

public class CustBookingServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
//        // Check if user is logged in
//        HttpSession session = request.getSession(false);
//        if (session == null || session.getAttribute("customerId") == null) {
//            response.sendRedirect("LoginServlet");
//            return;
//        }
        try {
            List<CafeTable> tables = CafeTableDAO.getAllTables();
            request.setAttribute("tables", tables);
        } catch (Exception e) {
            request.setAttribute("error", "Error loading tables: " + e.getMessage());
        }
        request.getRequestDispatcher("/ManageBookingCust.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
//        // Check if user is logged in
//        HttpSession session = request.getSession(false);
//        if (session == null || session.getAttribute("customerId") == null) {
//            response.sendRedirect("LoginServlet");
//            return;
//        }
        
        String action = request.getParameter("action");
        try {
            if ("selectDate".equals(action)) {
                handleDateSelection(request, response);
            } else if ("bookTable".equals(action)) {
                handleBooking(request, response);
            }
            else{
                request.getRequestDispatcher("/ManageBookingCust.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error processing request: " + e.getMessage());
            request.getRequestDispatcher("/ManageBookingCust.jsp").forward(request, response);
        }
    }

    private void handleDateSelection(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        Date selectedDate = Date.valueOf(request.getParameter("selectedDate"));
        List<CafeTable> tables = CafeTableDAO.getTablesWithStatus(selectedDate);
        
        request.setAttribute("tables", tables);
        request.setAttribute("selectedDate", selectedDate.toString());
        request.getRequestDispatcher("/ManageBookingCust.jsp").forward(request, response);
    }

    private void handleBooking(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customerId");

        if (customerId == null) {
            response.sendRedirect("LoginServlet");
            return;
        }
        
        Date bookDate = Date.valueOf(request.getParameter("bookDate"));
        String orderType = request.getParameter("orderType");
        
        
        Integer tableID = "DINE_IN".equals(orderType) ? 
            Integer.parseInt(request.getParameter("tableID")) : null;
        
        boolean success = BookingDAO.createBooking(customerId, bookDate, tableID, orderType);
        
        if (success) {
            // Store orderType and tableID in session for later use (e.g., checkout)
            session.setAttribute("orderType", orderType);
            if ("DINE_IN".equals(orderType)) {
                session.setAttribute("tableID", tableID);
            } else {
                session.removeAttribute("tableID");
            }
            response.sendRedirect("CustMenuServlet");
        } else {
            request.setAttribute("error", "Failed to create booking. Please try again.");
            request.getRequestDispatcher("/ManageBookingCust.jsp").forward(request, response);
        }
    }
}