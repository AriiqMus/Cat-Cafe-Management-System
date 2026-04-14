/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.StaffDAO;
import util.DBUtil;
import model.Staff;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.SpecialAccessDAO;
import model.SpecialAccess;

/**
 *
 * @author Muhammad Syakil bin Mohd Zaidi
 */
public class ManageSpecialAccessServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/ManageSpecialAccess.jsp");
        dispatcher.forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            processRequest(request, response);
            return;
        }

        RequestDispatcher dispatcher;

        try {
            SpecialAccessDAO SpecialAccessDAO = new SpecialAccessDAO(DBUtil.getConnection());
            switch (action) {
                case "searchSpecialAccess":
                    dispatcher = request.getRequestDispatcher("/WEB-INF/SearchSpecialAccess.jsp");
                    break;
                case "searchSpecialAccessById": {
                    int id = Integer.parseInt(request.getParameter("SpecialAccessId"));
                    SpecialAccess SpecialAccess = SpecialAccessDAO.getSpecialAccessById(id);
                    List<SpecialAccess> result = new ArrayList<>();
                    if (SpecialAccess != null) {
                        result.add(SpecialAccess);
                    }
                    request.setAttribute("result", result);

                    dispatcher = request.getRequestDispatcher("/WEB-INF/SearchResultSpecialAccess.jsp");
                    break;
                }
                case "createNewSpecialAccess":
                    dispatcher = request.getRequestDispatcher("/WEB-INF/CreateNewSpecialAccess.jsp");
                    break;
                case "seeAllSpecialAccess": {
                    List<SpecialAccess> SpecialAccessList = SpecialAccessDAO.getAllSpecialAccess();
                    request.setAttribute("SpecialAccessList", SpecialAccessList);
                    dispatcher = request.getRequestDispatcher("/WEB-INF/SeeAllSpecialAccess.jsp");
                    break;
                }
                case "editSpecialAccess": {
                    int id = Integer.parseInt(request.getParameter("staffId"));
                    SpecialAccess SpecialAccess = SpecialAccessDAO.getSpecialAccessById(id);
                    request.setAttribute("SpecialAccess", SpecialAccess);
                    dispatcher = request.getRequestDispatcher("/WEB-INF/UpdateSpecialAccess.jsp");
                    break;
                }
                default:
                    dispatcher = request.getRequestDispatcher("/WEB-INF/ManageSpecialAccess.jsp");
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }

        dispatcher.forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
