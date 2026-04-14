/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author Ariiq
 */
import model.Booking;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import util.DBUtil;

public class BookingDAO {

    public static boolean createBooking(int customerId, Date bookingDate, Integer tableID, String bookingType)
            throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO bookings (customerId, bookingDate, tableID, status, bookingType) "
                + "VALUES (?, ?, ?, 'CONFIRMED', ?)";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            stmt.setDate(2, bookingDate);
            if (tableID != null) {
                stmt.setInt(3, tableID);
            } else {
                stmt.setNull(3, Types.INTEGER);
            }
            stmt.setString(4, bookingType);
            return stmt.executeUpdate() > 0;
        }
    }

    public static boolean updateBookingStatus(int bookingID, String status) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE bookings SET status = ? WHERE bookingID = ?";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, bookingID);
            return stmt.executeUpdate() > 0;
        }
    }

    public static List<Booking> getBookingsByDate(Date date) throws SQLException, ClassNotFoundException {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.bookingID, b.customerId, c.customer_name, b.tableID, t.tableNumber, "
                + "b.bookingDate, b.status, b.bookingType "
                + "FROM bookings b "
                + "JOIN customer c ON b.customerId = c.customerId "
                + "LEFT JOIN cafe_tables t ON b.tableID = t.tableID "
                + "WHERE b.bookingDate = ?";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, date);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingID(rs.getInt("bookingID"));
                booking.setCustomerId(rs.getInt("customerId"));
                booking.setCustomer_name(rs.getString("customer_name"));
                booking.setTableID(rs.getObject("tableID") != null ? rs.getInt("tableID") : null);
                booking.setBookingDate(rs.getDate("bookingDate"));
                booking.setStatus(rs.getString("status"));
                booking.setBookingType(rs.getString("bookingType"));
                bookings.add(booking);
            }
        }
        return bookings;
    }
}
