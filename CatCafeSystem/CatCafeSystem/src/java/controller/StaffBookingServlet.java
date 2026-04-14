package controller;

import dao.BookingDAO;
import dao.CafeTableDAO;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Booking;
import model.CafeTable;

public class StaffBookingServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<CafeTable> tables = CafeTableDAO.getAllTables();
            request.setAttribute("tables", tables);
            
            if (request.getParameter("selectedDate") != null) {
                Date selectedDate = Date.valueOf(request.getParameter("selectedDate"));
                List<Booking> bookings = BookingDAO.getBookingsByDate(selectedDate);
                request.setAttribute("bookings", bookings);
                request.setAttribute("selectedDate", selectedDate.toString());
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error loading bookings: " + e.getMessage());
        }
        request.getRequestDispatcher("/ManageBookingStaff.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if ("selectDate".equals(action)) {
                handleDateSelection(request, response);
            } else if ("updateStatus".equals(action)) {
                handleStatusUpdate(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error processing request: " + e.getMessage());
            request.getRequestDispatcher("/ManageBookingStaff.jsp").forward(request, response);
        }
    }

    private void handleDateSelection(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        Date selectedDate = Date.valueOf(request.getParameter("selectedDate"));
        List<Booking> bookings = BookingDAO.getBookingsByDate(selectedDate);
        
        request.setAttribute("bookings", bookings);
        request.setAttribute("selectedDate", selectedDate.toString());
        request.getRequestDispatcher("/ManageBookingStaff.jsp").forward(request, response);
    }

    private void handleStatusUpdate(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        int bookingID = Integer.parseInt(request.getParameter("bookingID"));
        String status = request.getParameter("status");
        String selectedDate = request.getParameter("selectedDate");
        
        boolean success = BookingDAO.updateBookingStatus(bookingID, status);
        
        if (success) {
            response.sendRedirect("StaffBookingServlet?selectedDate=" + selectedDate);
        } else {
            request.setAttribute("error", "Failed to update booking status");
            request.getRequestDispatcher("/ManageBookingStaff.jsp").forward(request, response);
        }
    }
}