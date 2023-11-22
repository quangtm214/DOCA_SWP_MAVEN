/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.doca_java.Controller.Admin;

import com.mycompany.doca_java.DAO.userDAO;
import com.mycompany.doca_java.DTO.userDTO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author Admin
 */
@WebServlet(name = "SearchByUserName", urlPatterns = {"/SearchByUserName"})
public class SearchByUserName extends HttpServlet {

    private final String adminShowUser = "AdminUI/alluser.jsp";

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
        HttpSession session = request.getSession();
        String username = request.getParameter("txtSearch").trim();
        String indexPage = request.getParameter("index");
        if (indexPage == null) {
            indexPage = "1";
        }
        int index = Integer.parseInt(indexPage);
        try {
            userDAO userDAO = new userDAO();
            int count = userDAO.countSearch(username);
            int endPage = count / 6;
            if (count % 6 != 0) {
                endPage++;
            }
            request.setAttribute("endPage", endPage);
            List<userDTO> userList = userDAO.searchByUsername(username, index);

            if (userList != null) {
                // Set the search results as a request attribute
                request.setAttribute("userList", userList);
                request.setAttribute("save", username);
                session.setAttribute("indexStay", index);
            } else {
                request.setAttribute("ErroMessage", "Không tìm thấy tài khoản có tên : ");
            }

            // Forward the request to the JSP page to display the results
            RequestDispatcher dispatcher = request.getRequestDispatcher(adminShowUser);
            dispatcher.forward(request, response);
        } catch (SQLException | ClassNotFoundException | NamingException e) {
            e.printStackTrace(); // Handle exceptions appropriately in a production environment
        }
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
        processRequest(request, response);
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
