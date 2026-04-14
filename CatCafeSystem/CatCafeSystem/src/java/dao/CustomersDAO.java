/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Muhammad Syakil bin Mohd Zaidi
 */
package dao;

import model.Customers;
import model.InsertResult;
import model.CustomerStatus;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.mindrot.jbcrypt.BCrypt;

public class CustomersDAO {

    private Connection connection;

    public CustomersDAO(Connection connection) {
        this.connection = connection;
    }

    // Login validation and retrieving customer object
    public Customers getCustomerByLogin(String username, String password) throws SQLException {
        String sql = "SELECT * FROM customers WHERE customer_username = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("customer_password");
                if (storedPassword.equals(password)) {  // replace this with BCrypt if needed
                    Customers customer = new Customers();
                    customer.setCustomerId(rs.getInt("customerId"));
                    customer.setCustomerName(rs.getString("customer_name"));
                    customer.setCustomerUsername(rs.getString("customer_username"));
                    customer.setCustomerEmail(rs.getString("customer_email"));
                    customer.setCustomerPhoneNumber(rs.getString("customer_phone_number"));
                    customer.setCustomerBirthDate(rs.getDate("customer_birth_date"));
                    customer.setCustomerDateRegistered(rs.getDate("customer_date_registered"));
                    customer.setCustomerStatus(rs.getString("customer_status"));
                    customer.setCustomerPassword(rs.getString("customer_password")); // optional
                    return customer;
                }
            }
            return null;
        }
    }

    // Check if email already exists in the database
    public boolean isEmailTaken(String email) throws SQLException {
        String sql = "SELECT 1 FROM customers WHERE customer_email = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    // Check if username already exists in the database
    public boolean isUsernameTaken(String username) throws SQLException {
        String sql = "SELECT 1 FROM customers WHERE customer_username = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    // Insert new customer
    public InsertResult insertCustomer(String name, Date birthDate, String phone, String email,
                                       String password, String username, Date dateRegistered) throws SQLException {
        boolean emailTaken = isEmailTaken(email);
        boolean usernameTaken = isUsernameTaken(username);

        if (emailTaken || usernameTaken) {
            return new InsertResult(false, emailTaken, usernameTaken);
        }

        String sql = "INSERT INTO customers (customer_name, customer_birth_date, customer_phone_number, " +
                     "customer_email, customer_password, customer_username, customer_date_registered) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, name);
            stmt.setDate(2, new java.sql.Date(birthDate.getTime()));
            stmt.setString(3, phone);
            stmt.setString(4, email);
            stmt.setString(5, password);  // store plaintext password directly
            stmt.setString(6, username);
            stmt.setDate(7, new java.sql.Date(dateRegistered.getTime()));

            int rows = stmt.executeUpdate();
            return new InsertResult(rows > 0, false, false);
        }
    }

    public boolean updateCustomerStatus(int customerId, CustomerStatus newStatus) throws SQLException {
        String sql = "UPDATE customers SET customer_status = ? WHERE customerId = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, newStatus.name().toLowerCase());
            stmt.setInt(2, customerId);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean updateCustomerPartial(int customerId, String newEmail, String newPhone, String newPassword, String newUsername) throws SQLException {
        StringBuilder sql = new StringBuilder("UPDATE customers SET ");
        List<Object> params = new ArrayList<>();

        if (newEmail != null && !newEmail.trim().isEmpty()) {
            sql.append("customer_email = ?, ");
            params.add(newEmail);
        }
        if (newPhone != null && !newPhone.trim().isEmpty()) {
            sql.append("customer_phone_number = ?, ");
            params.add(newPhone);
        }
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            sql.append("customer_password = ?, ");
            params.add(newPassword);
        }
        if (newUsername != null && !newUsername.trim().isEmpty()) {
            sql.append("customer_username = ?, ");
            params.add(newUsername);
        }
        if (params.isEmpty()) return false;

        sql.setLength(sql.length() - 2);  // remove last comma
        sql.append(" WHERE customerId = ?");
        params.add(customerId);

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            return stmt.executeUpdate() > 0;
        }
    }

    public int getCustomerIdByUsername(String username) throws SQLException {
        String sql = "SELECT customerId FROM customers WHERE customer_username = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("customerId");
                } else {
                    throw new SQLException("Customer not found for username: " + username);
                }
            }
        }
    }
    
    public Customers getCustomerByUsername(String username) throws SQLException {
    String sql = "SELECT * FROM customers WHERE customer_username = ?";
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        stmt.setString(1, username);
        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                Customers customer = new Customers();
                customer.setCustomerId(rs.getInt("customerId"));
                customer.setCustomerName(rs.getString("customer_name"));
                customer.setCustomerUsername(rs.getString("customer_username"));
                customer.setCustomerEmail(rs.getString("customer_email"));
                customer.setCustomerPhoneNumber(rs.getString("customer_phone_number"));
                customer.setCustomerBirthDate(rs.getDate("customer_birth_date"));
                customer.setCustomerDateRegistered(rs.getDate("customer_date_registered"));
                customer.setCustomerStatus(rs.getString("customer_status"));
                customer.setCustomerPassword(rs.getString("customer_password")); // optional
                return customer;
            } else {
                return null;
            }
        }
    }
}

}
