package dao;

import model.Menu;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DBUtil;

public class MenuDAO {

    public static List<Menu> getAllMenu() throws SQLException, ClassNotFoundException {
        List<Menu> menus = new ArrayList<>();
        String sql = "SELECT menuID, menuName, menuPrice, category, image_url, is_available FROM menu";

        try (Connection conn = DBUtil.getConnection(); Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                menus.add(new Menu(
                        rs.getInt("menuID"),
                        rs.getString("menuName"),
                        rs.getDouble("menuPrice"),
                        rs.getString("category"),
                        rs.getString("image_url"),
                        rs.getBoolean("is_available")
                ));
            }
        }
        return menus;
    }

    public static void addMenu(Menu menu) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO menu (menuName, menuPrice, category, image_url, is_available) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, menu.getName());
            stmt.setDouble(2, menu.getPrice());
            stmt.setString(3, menu.getCategory());
            stmt.setString(4, menu.getImageUrl());
            stmt.setBoolean(5, menu.isIsAvailable());
            stmt.executeUpdate();
        }
    }

    public static void deleteMenu(int menuId) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM menu WHERE menuID = ?";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, menuId);
            stmt.executeUpdate();
        }
    }

    public static void toggleMenuAvailability(int menuId) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE menu SET is_available = NOT is_available WHERE menuID = ?";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, menuId);
            stmt.executeUpdate();
        }
    }

    public static String getImageUrl(int menuId) throws SQLException, ClassNotFoundException {
        String sql = "SELECT image_url FROM menu WHERE menuID = ?";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, menuId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("image_url");
            }
        }
        return null;
    }

    public static void updateMenu(Menu menu) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE menu SET menuName = ?, menuPrice = ?, category = ?, image_url = ?, is_available = ? WHERE menuID = ?";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, menu.getName());
            stmt.setDouble(2, menu.getPrice());
            stmt.setString(3, menu.getCategory());
            stmt.setString(4, menu.getImageUrl());
            stmt.setBoolean(5, menu.isIsAvailable());
            stmt.setInt(6, menu.getMenuID());
            stmt.executeUpdate();
        }
    }

    public static Menu getMenuById(int menuId) throws SQLException, ClassNotFoundException {
        String sql = "SELECT menuID, menuName, menuPrice, category, image_url, is_available FROM menu WHERE menuID = ?";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, menuId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Menu(
                        rs.getInt("menuID"),
                        rs.getString("menuName"),
                        rs.getDouble("menuPrice"),
                        rs.getString("category"),
                        rs.getString("image_url"),
                        rs.getBoolean("is_available")
                );
            }
        }
        return null;
    }
}
