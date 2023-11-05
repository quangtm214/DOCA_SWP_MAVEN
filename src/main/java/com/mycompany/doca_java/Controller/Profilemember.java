/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.doca_java.Controller;

import com.mycompany.doca_java.DAO.FeedbackDAO;
import com.mycompany.doca_java.DAO.PostDAO;
import com.mycompany.doca_java.DAO.ProductDAO;
import com.mycompany.doca_java.DAO.userDAO;
import com.mycompany.doca_java.DTO.PostDTO;
import com.mycompany.doca_java.DTO.ProductDTO;
import com.mycompany.doca_java.DTO.userDTO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name = "Profilemember", urlPatterns = {"/Profilemember"})
public class Profilemember extends HttpServlet {

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
        int userID = Integer.parseInt(request.getParameter("userId"));
        try {
            ProductDAO productdao = new ProductDAO();
            List<ProductDTO> productlist = productdao.getProductsOtherUser(userID);
            PostDAO postdao = new PostDAO();
            List<PostDTO> postlist = postdao.getPostsByOtherUser(userID);
            //get user by userID
            userDAO uDAO = new userDAO();
            userDTO OwnerProfile = uDAO.getUserbyUserID(userID);
            request.setAttribute("productlist", productlist);
            request.setAttribute("postlist", postlist);
            request.setAttribute("OwnerProfile", OwnerProfile);
            FeedbackDAO fDao = new FeedbackDAO();
            double averageRate = fDao.getAverageRateBySellerId(userID);
            DecimalFormat decimalFormat = new DecimalFormat("#.##");
            String formattedAverageRate = decimalFormat.format(averageRate);
            int feedbackCount = fDao.getFeedbackCountBySellerId(userID);
            request.setAttribute("averageRate", formattedAverageRate);
            request.setAttribute("feedbackCount", feedbackCount);

            RequestDispatcher dispatcher = request.getRequestDispatcher("profilemember.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions appropriately, e.g., display an error page
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
