/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author sitif
 */
import java.sql.*;
import java.util.*;
import model.CatFood;

public class CatFoodDAO {

    private Connection conn;

    public CatFoodDAO(Connection conn) {
        this.conn = conn;
    }

    // Method to fetch all cat foods
    public List<CatFood> getAllCatFoods() throws SQLException {
        List<CatFood> list = new ArrayList<>();
        String sql = "SELECT * FROM cat_food";

        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            CatFood food = new CatFood(
                    rs.getString("name"),
                    rs.getInt("quantity")
            );
            food.setFoodID(rs.getInt("food_id"));  // Set foodID from the result set
            list.add(food);
        }

        return list;
    }

    // Method to search cat food by name (partial match)
    public List<CatFood> searchCatFoodByName(String keyword) throws SQLException {
        List<CatFood> list = new ArrayList<>();
        String sql = "SELECT * FROM cat_food WHERE name LIKE ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + keyword + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                CatFood food = new CatFood(rs.getString("name"), rs.getInt("quantity"));
                food.setFoodID(rs.getInt("food_id"));
                list.add(food);
            }
        }

        return list;
    }

    // Method to insert a new cat food record
    public void addCatFood(CatFood food) throws SQLException {
        String sql = "INSERT INTO cat_food (name, quantity) VALUES (?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, food.getName());
            stmt.setInt(2, food.getQuantity());
            stmt.executeUpdate();
        }
    }

    //Method to delete cat food
    public void deleteCatFood(int foodID) throws SQLException {
        String sql = "DELETE FROM cat_food WHERE food_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, foodID);
            stmt.executeUpdate();
        }
    }

    public CatFood getCatFoodById(int foodID) throws SQLException {
        String sql = "SELECT * FROM cat_food WHERE food_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, foodID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                CatFood food = new CatFood(rs.getString("name"), rs.getInt("quantity"));
                food.setFoodID(foodID);
                return food;
            }
            return null;
        }
    }

    public void updateCatFood(CatFood food) throws SQLException {
        String sql = "UPDATE cat_food SET name = ?, quantity = ? WHERE food_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, food.getName());
            stmt.setInt(2, food.getQuantity());
            stmt.setInt(3, food.getFoodID());
            stmt.executeUpdate();
        }
    }

}
