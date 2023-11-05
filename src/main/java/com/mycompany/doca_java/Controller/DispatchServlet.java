/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.doca_java.Controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
@MultipartConfig
public class DispatchServlet extends HttpServlet {

    private final String Login_Servlet = "LoginServlet";
    private final String CREATE_ACCOUNT = "CreateNewAccountServlet";
    private final String Market_Controller = "marketServlet";
    private final String FORUM_Controller = "forumServlet";
    private final String Fitler_Product = "filterProduct";
    private final String Save_Product = "updateSaveProductServlet";
    private final String CREATE_COMMENT = "createCommentServlet";
    private final String SEARCH_IN_MARKET = "searchInMarketServlet";
    private final String SEARCH_IN_FORUM = "SearchInForumServlet";
    private final String UPDATE_INFO_ACCOUNT = "UpdateAccountServlet";

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
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String button = request.getParameter("btAction");
        String url = "";
        try {
            if (button.equals("goTomarket")) {
                session.removeAttribute("listOfProduct");
                request.removeAttribute("numberPage");
                request.removeAttribute("listInPage");
                session.removeAttribute("indexPageMarket");
                session.removeAttribute("selectedLocal");
                session.removeAttribute("selectedLowerPrice");
                session.removeAttribute("selectedCategory");
                session.removeAttribute("listOfProductSearch");
                session.removeAttribute("LastSearch");
                url = Market_Controller;
            }
            if (button.equals("goToForum")) {
                request.removeAttribute("listOfPost");
                request.removeAttribute("indexcategoryID");
                request.removeAttribute("listInPage");
                request.removeAttribute("numberPage");
                session.removeAttribute("indexPageForum");
                session.removeAttribute("listOfPostSearch");
                session.removeAttribute("LastSearch");
                url = FORUM_Controller;
            }

            if (button.equals("Lọc")) {
                url = Fitler_Product;
            }
            if (button.equals("saveProduct")) {
                url = Save_Product;
            }
            if (button.equals("Log In")) {
                url = Login_Servlet;
            }
            if (button.equals("send")) {
                url = CREATE_COMMENT;
            }
            if (button.equals("Create New Account")) {
                url = CREATE_ACCOUNT;
            }
            if (button.equals("searchMarket")) {
                session.removeAttribute("listOfProduct");
                request.removeAttribute("numberPage");
                request.removeAttribute("listInPage");
                session.removeAttribute("indexPageMarket");
                session.removeAttribute("selectedLocal");
                session.removeAttribute("selectedLowerPrice");
                session.removeAttribute("selectedCategory");
                session.removeAttribute("listOfProductSearch");
                session.removeAttribute("LastSearch");
                url = SEARCH_IN_MARKET;
            }
            if (button.equals("searchForum")) {
                 request.removeAttribute("listOfPost");
                request.removeAttribute("indexcategoryID");
                request.removeAttribute("listInPage");
                request.removeAttribute("numberPage");
                session.removeAttribute("indexPageForum");
                session.removeAttribute("listOfPostSearch");
                session.removeAttribute("LastSearch");
                url = SEARCH_IN_FORUM;
            }
             if (button.equals("Thay đổi thông tin")) {
                url = UPDATE_INFO_ACCOUNT;
            }
            
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
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
