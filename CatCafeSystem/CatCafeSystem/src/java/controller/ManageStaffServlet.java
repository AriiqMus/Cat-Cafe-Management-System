package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import model.Staff;

public class ManageStaffServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String search = request.getParameter("search");
        List<Staff> staffList = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/catcafedb2", "root", "admin");
            
            String sql = "SELECT * FROM staff";
            if (search != null && !search.trim().isEmpty()) {
                sql += " WHERE name LIKE ? OR staff_id LIKE ?";
            }
            PreparedStatement ps = conn.prepareStatement(sql);
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(1, "%" + search + "%");
                ps.setString(2, "%" + search + "%");
            }
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Staff staff = new Staff();
                staff.setStaffId(rs.getString("staff_id"));
                staff.setName(rs.getString("name"));
                staff.setUsername(rs.getString("username"));
                staff.setRole(rs.getString("role"));
                staffList.add(staff);
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("staffList", staffList);
        request.getRequestDispatcher("ManageStaff.jsp").forward(request, response);
    }
}
