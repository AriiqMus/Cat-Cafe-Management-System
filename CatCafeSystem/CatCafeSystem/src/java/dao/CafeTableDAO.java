/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author Ariiq
 */

import model.CafeTable;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.CafeTable;
import util.DBUtil;

public class CafeTableDAO {

    public static List<CafeTable> getTablesWithStatus(Date date) throws SQLException, ClassNotFoundException {
        List<CafeTable> tables = new ArrayList<>();
        String sql = "SELECT t.tableID, t.tableNumber, t.tableType, " +
                    "CASE WHEN b.bookingID IS NULL THEN 'AVAILABLE' ELSE 'OCCUPIED' END as status " +
                    "FROM cafe_tables t LEFT JOIN (SELECT * FROM bookings WHERE bookingDate = ? AND status = 'CONFIRMED') b " +
                    "ON t.tableID = b.tableID";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, date);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                tables.add(new CafeTable(
                    rs.getInt("tableID"),
                    rs.getString("tableNumber"),
                    rs.getString("tableType"),
                    rs.getString("status")
                ));
            }
        }
        return tables;
    }
    
    public static List<CafeTable> getAllTables() throws SQLException, ClassNotFoundException {
        List<CafeTable> tables = new ArrayList<>();
        String sql = "SELECT tableID, tableNumber, tableType, status FROM cafe_tables";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                tables.add(new CafeTable(
                    rs.getInt("tableID"),
                    rs.getString("tableNumber"),
                    rs.getString("tableType"),
                    rs.getString("status")
                ));
            }
        }
        return tables;
    }
}