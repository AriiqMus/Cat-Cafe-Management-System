/**
 *
 * @author sitif
 */
package controller;

import dao.CatProfileDao;
import model.CatProfile;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class HomepageServlet extends HttpServlet {

    private Connection conn;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/catcafedb2", "root", "admin");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);  // <--- important: fail if connection failed
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            CatProfileDao dao = new CatProfileDao(conn);
            CatProfile randomCat = dao.getRandomCat();

            request.setAttribute("randomCat", randomCat);

            RequestDispatcher rd = request.getRequestDispatcher("homepage.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
