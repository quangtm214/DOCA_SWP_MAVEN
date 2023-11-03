/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.doca_java.Controller.like;

import com.mycompany.doca_java.DAO.likeDAO;
import com.mycompany.doca_java.DTO.userDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import javax.naming.NamingException;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpdateLike", urlPatterns = {"/UpdateLike"})
public class UpdateLike extends HttpServlet {

    private final String LOGIN_PAGE = "login.jsp";

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
        HttpSession session = request.getSession(true);
        userDTO account = (userDTO) session.getAttribute("USER_NAME");
        int postID = Integer.parseInt(request.getParameter("postId"));
        int category = Integer.parseInt(request.getParameter("slectedCategoryID"));
        int indexPage = session.getAttribute("indexPageForum") != null
                ? (int) session.getAttribute("indexPageForum") : 1;
        boolean isLiked = Boolean.parseBoolean(request.getParameter("isLiked"));
        String url = "";
        try {
            if (account != null) {
                 likeDAO dao = new likeDAO();
                if (isLiked) {
                    boolean result = dao.deleteLike(account.getUser_ID(), postID);
                    if (result) {
                        url = "forumServlet"
                                + "?categoryID=" + category
                                + "&index=" + indexPage;
                    }
                } else {
                    boolean result = dao.insertLike(account.getUser_ID(), postID);
                    if (result) {
                        url = "forumServlet"
                                + "?categoryID=" + category
                                + "&index=" + indexPage;
                    }
                }
            } else {
                url = LOGIN_PAGE;
            }
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        } catch (NamingException ex) {
            ex.printStackTrace();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            response.sendRedirect(url);
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
