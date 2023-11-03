/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.doca_java.Controller.ManageOwner.savedProduct;

import com.mycompany.doca_java.DAO.saveProductDAO;
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
@WebServlet(name = "updateSaveProductServlet", urlPatterns = {"/updateSaveProductServlet"})
public class updateSaveProductServlet extends HttpServlet {

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

        String local = session.getAttribute("selectedLocal") != null ? 
                (String) session.getAttribute("selectedLocal") : "";
        float lowerPrice = session.getAttribute("selectedLowerPrice") != null ? 
                (float) session.getAttribute("selectedLowerPrice") : 0.0f;
        int category = session.getAttribute("selectedCategory") != null ? 
                (int) session.getAttribute("selectedCategory") : 0;
        int productID = Integer.parseInt(request.getParameter("productIDChangeSave"));
        userDTO account = (userDTO) session.getAttribute("USER_NAME");
        boolean isSaved = Boolean.parseBoolean(request.getParameter("isSaved"));

       int indexPage = session.getAttribute("indexPageMarket") != null ? 
                (int) session.getAttribute("indexPageMarket") : 1;

        String url = "";
        try {
            if (account != null) {
                saveProductDAO dao = new saveProductDAO();
                if (!isSaved) {
                    boolean result = dao.createSaveProduct(account.getUser_ID(), productID);//get userID form sessionScope
                    if (result) {
                        url = "filterProduct"
                                + "?city=" + local
                                + "&lowerPrice=" + lowerPrice
                                + "&category=" + category
                                + "&indexFromSaveProduct=" + indexPage;
                    }
                } else {
                    boolean result = dao.deleteSaveProduct(account.getUser_ID(), productID);//get userID form sessionScope
                    if (result) {
                        url = "filterProduct"
                                + "?city=" + local
                                + "&lowerPrice=" + lowerPrice
                                + "&category=" + category
                                + "&indexFromSaveProduct=" + indexPage;
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
