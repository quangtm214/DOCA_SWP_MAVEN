/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.doca_java.Controller.loginSignup;

import com.mycompany.doca_java.DTO.GoogleDTO;
import com.mycompany.doca_java.DTO.userDTO;
import com.mycompany.doca_java.DAO.userDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;

/**
 *
 * @author ADMIN
 */
public class GoogleSigninServlet extends HttpServlet {

    private final String Market_Controller = "marketServlet";

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
            throws ServletException, IOException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");

        String url = "market.jsp";
        HttpSession session = request.getSession(true);
        String code = request.getParameter("code");
        try {
            String accessToken = GoogleSupport.getToken(code);
            GoogleDTO userToken = GoogleSupport.getUserInfo(accessToken);

            String username = userToken.getName();
            String email = userToken.getEmail();
            String fullName = userToken.getGiven_name();
            String avatar = userToken.getPicture();
            userDAO dao = new userDAO();
            boolean isEmailAvailable = dao.isEmailAvailable(email);
   //         boolean isUsernameAvailable = dao.isUsernameAvailable(username);
//                userDTO user = new userDTO(0, username, "123", "null", email, "null", true, true, avatar);
//                boolean result = dao.createUser(user);
            String password = "";
            if (isEmailAvailable) {
                userDTO user = new userDTO(username, "123", "null", email, "null", true, true, avatar);
                password="123";
                boolean result = dao.createUser(user);
            } else if (!isEmailAvailable) {
                // Email already exists, retrieve user information
                userDTO users = dao.getUserByEmail(email);
                if (users != null) {
                    url = Market_Controller;
                    username = users.getUserName();
                    password= users.getPassword();
                }
            }// Add checkLogin functionality
            userDTO loginResult = dao.checkLogin(username,password);
            if (loginResult != null) {
                url = Market_Controller; // Change to the appropriate URL for the market controller
                session.setAttribute("USER_NAME", loginResult);
            }
        } catch (NamingException ex) {
            log("CreateNewAccount_naming" + ex.getMessage());
        } catch (SQLException ex) {
            log("CreateNewAccount_SQL" + ex.getMessage());
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(GoogleSigninServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(GoogleSigninServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
