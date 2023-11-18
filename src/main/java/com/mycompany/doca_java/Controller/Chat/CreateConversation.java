/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.doca_java.Controller.Chat;

import com.mycompany.doca_java.DAO.ConversationDAO;
import com.mycompany.doca_java.DAO.saveProductDAO;
import com.mycompany.doca_java.DTO.ConversationDTO;
import com.mycompany.doca_java.DTO.userDTO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "CreateConversation", urlPatterns = {"/CreateConversation"})
public class CreateConversation extends HttpServlet {

    private final String LOGIN_PAGE = "login.jsp";
    private final String GET_CONVERSATIONLIST = "getConversationServlet";

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
        HttpSession session = request.getSession();
        int ProductID = Integer.parseInt(request.getParameter("ProductID"));
        userDTO account = (userDTO) session.getAttribute("USER_NAME");

        try {
            if (account != null) {
                int sellerID;
                int buyerID;
                String sellerIDParameter = request.getParameter("sellerID");
                String buyerIDParameter = request.getParameter("buyerID");
                if (sellerIDParameter != null && !sellerIDParameter.isEmpty()) {
                    sellerID = Integer.parseInt(sellerIDParameter);
                } else {
                    sellerID = account.getUser_ID();
                }
                if (buyerIDParameter != null && !buyerIDParameter.isEmpty()) {
                    buyerID = Integer.parseInt(buyerIDParameter);
                } else {
                    buyerID = account.getUser_ID();
                }
                saveProductDAO sdao = new saveProductDAO();
                sdao.createSaveProduct(buyerID, ProductID);
                ConversationDTO NewConversation = new ConversationDTO(ProductID, buyerID, sellerID);
                //check if the conversation have exited
                ConversationDAO dao = new ConversationDAO();
                boolean result = dao.insertConversation(NewConversation);
                if (result == false) {
                    ConversationDTO stayConversation = dao.getOldConversation(ProductID, buyerID, sellerID);
                    request.setAttribute("stayConversation", stayConversation);
                }
                url = GET_CONVERSATIONLIST;
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
