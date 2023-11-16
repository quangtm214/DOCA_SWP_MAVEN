/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.doca_java.Controller.ManageOwner.savedProduct;

import com.google.gson.Gson;
import com.mycompany.doca_java.DAO.ConversationDAO;
import com.mycompany.doca_java.DAO.saveProductDAO;
import com.mycompany.doca_java.DAO.userDAO;
import com.mycompany.doca_java.DTO.ConversationDTO;
import com.mycompany.doca_java.DTO.saveProductDTO;
import com.mycompany.doca_java.DTO.userDTO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author Admin
 */
@WebServlet(name = "getListUserHavedSaveProduct", urlPatterns = {"/getListUserHavedSaveProduct"})
public class getListUserHavedSaveProduct extends HttpServlet {

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
        int productID = Integer.parseInt(request.getParameter("productId"));
        String url = "";
        try {
            saveProductDAO sdao = new saveProductDAO();
            userDAO uDao = new userDAO();
            List<saveProductDTO> listSaveProduct= sdao.getListSaveProductDTO(productID);
            List<Integer> listuserID = sdao.getUserIDsByProductID(productID);
            List<userDTO> listUser = new ArrayList<>();
            for (Integer integer : listuserID) {
                userDTO user = uDao.getUserbyUserID(integer);
                listUser.add(user);
            }
            ConversationDAO cdao = new ConversationDAO();
            List<ConversationDTO> listConverOfProduct = cdao.getListTheConversationByProductID(productID);
            if (listConverOfProduct != null) {
                request.setAttribute("listConverOfProduct", listConverOfProduct);
            }
            request.setAttribute("listUserHaveSave", listUser);
            request.setAttribute("productID", productID);
            request.setAttribute("listSaveProduct", listSaveProduct);
            url = "listMemberHaveLikeProduct.jsp";

        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        } catch (NamingException ex) {
            ex.printStackTrace();
        } catch (SQLException ex) {
            ex.printStackTrace();
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
