/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.doca_java.Controller.ManageOwner.personal_Product;

import com.mycompany.doca_java.DAO.ProductDAO;
import com.mycompany.doca_java.DAO.saveProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import javax.naming.NamingException;

/**
 *
 * @author Admin
 */
@WebServlet(name = "resaledProduct", urlPatterns = {"/resaledProduct"})
public class resaledProduct extends HttpServlet {

    private final String statusSaled = "saled";
    private final String statusWating = "waiting";
    private final String statusReject = "reject";
    private final String statusBanned = "ban";
    private final String statusUnfollow = "unfollow";
    private final String statusResale = "resale";

    private final String statusApprove = "approved";
    public static final String PERSONAL_PRODUCT_PAGE = "getPersonalProduct";

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
        String url = "";
        try {
            String productId = request.getParameter("producID");
            saveProductDAO dao = new saveProductDAO();
            ProductDAO pdao = new ProductDAO();
            boolean result = false;
            result = dao.setStatusSaveProduct(Integer.parseInt(productId), statusReject, statusResale);
            dao.setStatusSaveProduct(Integer.parseInt(productId), statusUnfollow, statusResale);
//            dao.setRejectSaveProduct(Integer.parseInt(productId), statusSaled, statusBanned);
            pdao.setStatusProduct(Integer.parseInt(productId), statusApprove);
            url = PERSONAL_PRODUCT_PAGE;
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
