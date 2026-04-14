package dao;

import model.Order;
import model.OrderItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Menu;
import static util.DBUtil.getConnection;

public class OrderDAO {

    public static int createOrder(Order order) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO orders (customerId, orderType, status, payment_method, total_amount, tableID) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try ( Connection conn = getConnection();  PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, order.getCustomerId());
            stmt.setString(2, order.getOrderType());
            stmt.setString(3, order.getStatus());
            stmt.setString(4, order.getPaymentMethod());
            stmt.setDouble(5, order.getTotalAmount());

            if (order.getTableID() != null) {
                stmt.setInt(6, order.getTableID());
            } else {
                stmt.setNull(6, Types.INTEGER);
            }

            stmt.executeUpdate();

            try ( ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

            throw new SQLException("Failed to create order, no ID obtained");
        }
    }

    public static boolean addOrderItem(OrderItem item) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO order_items (orderID, menuID, quantity, price) "
                + "VALUES (?, ?, ?, ?)"; // Fixed to 4 parameters

        try ( Connection conn = getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, item.getOrderID());
            stmt.setInt(2, item.getMenuID());
            stmt.setInt(3, item.getQuantity());
            stmt.setDouble(4, item.getPrice());

            return stmt.executeUpdate() > 0;
        }
    }

    public static boolean updateOrderStatus(int orderID, String status) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE orders SET status = ? WHERE orderID = ?";

        try ( Connection conn = getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, orderID);
            return stmt.executeUpdate() > 0;
        }
    }

    public static List<Order> getOrdersByCustomer(int custID) throws SQLException, ClassNotFoundException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE customerId = ? ORDER BY orderDate DESC";

        try ( Connection conn = getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, custID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderID(rs.getInt("orderID"));
                order.setCustomerId(rs.getInt("customerId"));
                order.setOrderType(rs.getString("orderType"));
                order.setOrderDate(rs.getTimestamp("orderDate"));
                order.setStatus(rs.getString("status"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setTableID(rs.getObject("tableID") != null ? rs.getInt("tableID") : null);
                orders.add(order);
            }
        }
        return orders;
    }

    public static List<OrderItem> getOrderItems(int orderID) throws SQLException, ClassNotFoundException {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT oi.*, m.menuName, m.image_url FROM order_items oi "
                + "JOIN menu m ON oi.menuID = m.menuID "
                + "WHERE oi.orderID = ?";

        try ( Connection conn = getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setOrderItemID(rs.getInt("order_itemID"));
                item.setOrderID(rs.getInt("orderID"));
                item.setMenuID(rs.getInt("menuID"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getDouble("price"));

                Menu menu = new Menu();
                menu.setMenuID(rs.getInt("menuID"));
                menu.setName(rs.getString("menuName"));
                menu.setImageUrl(rs.getString("image_url"));
                item.setMenu(menu);
                items.add(item);
            }
        }
        return items;
    }

    public static List<Order> getCustomerOrders(int custID) throws SQLException, ClassNotFoundException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE customerId = ? ORDER BY orderDate DESC";

        try ( Connection conn = getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, custID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderID(rs.getInt("orderID"));
                order.setOrderType(rs.getString("orderType"));
                order.setOrderDate(rs.getTimestamp("orderDate"));
                order.setStatus(rs.getString("status"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                orders.add(order);
            }
        }
        return orders;
    }

    public static Order getOrderDetails(int orderID) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM orders WHERE orderID = ?";

        try ( Connection conn = getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Order order = new Order();
                order.setOrderID(rs.getInt("orderID"));
                order.setCustomerId(rs.getInt("customerId"));
                order.setOrderType(rs.getString("orderType"));
                order.setOrderDate(rs.getTimestamp("orderDate"));
                order.setStatus(rs.getString("status"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setTableID(rs.getObject("tableID") != null ? rs.getInt("tableID") : null);
                return order;
            }
        }
        return null;
    }
}
