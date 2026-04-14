/**
 *
 * @author sitif
 */
package controller;

import dao.CatProfileDao;
import model.CatProfile;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

public class CatProfileServlet extends HttpServlet {

    private Connection conn;

    public void init() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/catcafedb2", "root", "admin");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CatProfileDao dao = new CatProfileDao(conn);
        String idParam = request.getParameter("id");

        try {
            if (idParam != null) {
                // single cat view
                int id = Integer.parseInt(idParam);
                CatProfile cat = dao.getCatById(id);
                request.setAttribute("cat", cat);
                RequestDispatcher rd = request.getRequestDispatcher("cat_profile.jsp");
                rd.forward(request, response);
            } else {
                // list view
                List<CatProfile> catList = dao.getAllCats();
                request.setAttribute("catList", catList);
                CatProfile randomCat = dao.getRandomCat();
                request.setAttribute("randomCat", randomCat);

                // Detect role from session
                HttpSession session = request.getSession(false);
                String role = (session != null && session.getAttribute("role") != null)
                        ? (String) session.getAttribute("role") : "guest";

                if ("Admin".equalsIgnoreCase(role) || "Staff".equalsIgnoreCase(role)) {
                    RequestDispatcher rd = request.getRequestDispatcher("cat_profiles_admin.jsp");
                    rd.forward(request, response);
                } else {
                    RequestDispatcher rd = request.getRequestDispatcher("cat_list.jsp");
                    rd.forward(request, response);
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
