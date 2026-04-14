package dao;

import model.Order;
import model.OrderItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Menu;
import static util.DBUtil.getConnection;

public class StaffOrderDAO {
    
    // Get all orders (for staff view)
    public static List<Order> getAllOrders() throws SQLException, ClassNotFoundException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, c.customer_name FROM orders o " +
                     "LEFT JOIN customers c ON o.customerId = c.customerId " +
                     "ORDER BY o.orderDate DESC";
        
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Order order = new Order();
                order.setOrderID(rs.getInt("orderID"));
                order.setCustomerId(rs.getObject("customerId") != null ? rs.getInt("customerId") : null);
                order.setCustomerName(rs.getString("customer_name"));
                order.setOrderType(rs.getString("orderType"));
                order.setOrderDate(rs.getTimestamp("orderDate"));
                order.setStatus(rs.getString("status"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setTableID(rs.getObject("tableID") != null ? rs.getInt("tableID") : null);
                order.setPaymentMethod(rs.getString("payment_method"));
                orders.add(order);
            }
        }
        return orders;
    }
    
    // Get orders filtered by status
    public static List<Order> getOrdersByStatus(String status) throws SQLException, ClassNotFoundException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, c.customer_name FROM orders o " +
                     "LEFT JOIN customers c ON o.customerId = c.customerId " +
                     "WHERE o.status = ? ORDER BY o.orderDate DESC";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Order order = new Order();
                order.setOrderID(rs.getInt("orderID"));
                order.setCustomerId(rs.getObject("customerId") != null ? rs.getInt("customerId") : null);
                order.setCustomerName(rs.getString("customer_name"));
                order.setOrderType(rs.getString("orderType"));
                order.setOrderDate(rs.getTimestamp("orderDate"));
                order.setStatus(rs.getString("status"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setTableID(rs.getObject("tableID") != null ? rs.getInt("tableID") : null);
                order.setPaymentMethod(rs.getString("paymentMethod"));
                orders.add(order);
            }
        }
        return orders;
    }
    
    // Update order status (same as OrderDAO but kept here for completeness)
    public static boolean updateOrderStatus(int orderID, String status) throws SQLException, ClassNotFoundException {
        return OrderDAO.updateOrderStatus(orderID, status);
    }
    
    // Get order details with customer info
    public static Order getOrderWithCustomer(int orderID) throws SQLException, ClassNotFoundException {
        String sql = "SELECT o.*, c.customer_name, c.customer_phone_number " +
                     "FROM orders o LEFT JOIN customers c ON o.customerId = c.customerId " +
                     "WHERE o.orderID = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Order order = new Order();
                order.setOrderID(rs.getInt("orderID"));
                order.setCustomerId(rs.getObject("customerId") != null ? rs.getInt("customerId") : null);
                order.setCustomerName(rs.getString("customer_name"));
                order.setCustomerPhone(rs.getString("customer_phone_number"));
                order.setOrderType(rs.getString("orderType"));
                order.setOrderDate(rs.getTimestamp("orderDate"));
                order.setStatus(rs.getString("status"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setTableID(rs.getObject("tableID") != null ? rs.getInt("tableID") : null);
                order.setPaymentMethod(rs.getString("paymentMethod"));
                return order;
            }
        }
        return null;
    }
}