/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.SpecialAccess;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.mindrot.jbcrypt.BCrypt;
/**
 *
 * @author Muhammad Syakil bin Mohd Zaidi
 */
public class SpecialAccessDAO {
    private final Connection connection;

    public SpecialAccessDAO(Connection connection) {
        this.connection = connection;
    }

    // Insert
    public boolean insertSpecialAccess(SpecialAccess access) throws SQLException {
        String sql = "INSERT INTO special_access (special_access_type, special_access_name, special_access_password) VALUES (?, ?, ?)";
        String hashed = BCrypt.hashpw(access.getSpecialAccessPassword(), BCrypt.gensalt());
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, access.getSpecialAccessType());
            stmt.setString(2, access.getSpecialAccessName());
            stmt.setString(3, hashed);
            return stmt.executeUpdate() > 0;
        }
    }

    // Read by ID
    public SpecialAccess getSpecialAccessById(int id) throws SQLException {
        String sql = "SELECT * FROM special_access WHERE special_access_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new SpecialAccess(
                    rs.getInt("special_access_id"),
                    rs.getString("special_access_type"),
                    rs.getString("special_access_name"),
                    rs.getString("special_access_password")
                );
            }
            return null;
        }
    }

    // Read All
    public List<SpecialAccess> getAllSpecialAccess() throws SQLException {
        List<SpecialAccess> list = new ArrayList<>();
        String sql = "SELECT * FROM special_access";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(new SpecialAccess(
                    rs.getInt("special_access_id"),
                    rs.getString("special_access_type"),
                    rs.getString("special_access_name"),
                    rs.getString("special_access_password")
                ));
            }
        }
        return list;
    }

    // Update
    public boolean updateSpecialAccess(SpecialAccess access) throws SQLException {
        String sql = "UPDATE special_access SET special_access_type = ?, special_access_name = ?, special_access_password = ? WHERE special_access_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, access.getSpecialAccessType());
            stmt.setString(2, access.getSpecialAccessName());
            stmt.setString(3, access.getSpecialAccessPassword());
            stmt.setInt(4, access.getSpecialAccessId());
            return stmt.executeUpdate() > 0;
        }
    }

    // Delete
    public boolean deleteSpecialAccess(int id) throws SQLException {
        String sql = "DELETE FROM special_access WHERE special_access_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    // Validate Admin Login
public boolean validateAdminLogin(String name, String password) throws SQLException {
    return validateLoginByType(name, password, "admin");
}

// Validate Staff Login
public boolean validateStaffLogin(String name, String password) throws SQLException {
    return validateLoginByType(name, password, "staff");
}

// Shared Internal Method
private boolean validateLoginByType(String name, String password, String type) throws SQLException {
    String sql = "SELECT special_access_password FROM special_access WHERE special_access_name = ? AND special_access_type = ?";
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        stmt.setString(1, name);
        stmt.setString(2, type);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            String hashed = rs.getString("special_access_password");
            return BCrypt.checkpw(password, hashed);
        }
        return false;
    }
}
}