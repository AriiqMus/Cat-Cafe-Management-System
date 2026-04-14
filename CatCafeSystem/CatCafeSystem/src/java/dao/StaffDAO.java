package dao;

import model.Staff;
import java.sql.*;
import java.util.*;

public class StaffDAO {

    private final Connection connection;

    public StaffDAO(Connection connection) {
        this.connection = connection;
    }

    // Insert
    public boolean insertStaff(Staff staff) throws SQLException {
        String sql = "INSERT INTO staff (staff_id, name, username, password, role) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, staff.getStaffId());
            stmt.setString(2, staff.getName());
            stmt.setString(3, staff.getUsername());
            stmt.setString(4, staff.getPassword());
            stmt.setString(5, staff.getRole());
            return stmt.executeUpdate() > 0;
        }
    }

    // Get All Staff
    public List<Staff> getAllStaff() throws SQLException {
        List<Staff> staffList = new ArrayList<>();
        String sql = "SELECT * FROM staff";
        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Staff staff = new Staff(
                    rs.getString("staff_id"),
                    rs.getString("name"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("role")
                );
                staffList.add(staff);
            }
        }
        return staffList;
    }

    // Get Staff by ID
    public Staff getStaffById(String staffId) throws SQLException {
        String sql = "SELECT * FROM staff WHERE staff_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, staffId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Staff(
                    rs.getString("staff_id"),
                    rs.getString("name"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("role")
                );
            }
        }
        return null;
    }

    // Update Staff
    public boolean updateStaff(Staff staff) throws SQLException {
        String sql = "UPDATE staff SET name = ?, username = ?, password = ?, role = ? WHERE staff_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, staff.getName());
            stmt.setString(2, staff.getUsername());
            stmt.setString(3, staff.getPassword());
            stmt.setString(4, staff.getRole());
            stmt.setString(5, staff.getStaffId());
            return stmt.executeUpdate() > 0;
        }
    }

    // Delete Staff
    public boolean deleteStaff(String staffId) throws SQLException {
        String sql = "DELETE FROM staff WHERE staff_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, staffId);
            return stmt.executeUpdate() > 0;
        }
    }
}
