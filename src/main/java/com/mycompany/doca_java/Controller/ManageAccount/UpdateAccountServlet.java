/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.doca_java.Controller.ManageAccount;

import com.mycompany.doca_java.Constant.Folder_Up;
import com.mycompany.doca_java.DAO.userDAO;
import com.mycompany.doca_java.DTO.userDTO;
import com.mycompany.doca_java.ProcessDetails.ProcessImg;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.SQLException;
import javax.naming.NamingException;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpdateAccountServlet", urlPatterns = {"/UpdateAccountServlet"})
@MultipartConfig
public class UpdateAccountServlet extends HttpServlet {

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
        String url = "accountmanage.jsp";
        boolean isUsernameTaken = true;
        boolean isEmailTaken = true;
        try {
            HttpSession session = request.getSession();
            userDTO account = (userDTO) session.getAttribute("USER_NAME");
            String userName = request.getParameter("txtUsername");
            String gender = request.getParameter("txtGender");
            String email = request.getParameter("txtEmail");
            String mobileNum = request.getParameter("txtPhone");
            String avatar = "";
            userDAO userDao = new userDAO();
            Part filePart = request.getPart("avatar");
            if (filePart != null && filePart.getSize() > 0) {
                InputStream fileInputStream = filePart.getInputStream();
                // Upload the image to Cloudinary
                // Process the image using the ImageProcessor class
                ProcessImg imageProcessor = new ProcessImg();
                String imageUrl = imageProcessor.uploadImageToFolder(fileInputStream, Folder_Up.USER_UP);
                avatar=imageUrl;
            } else {
                avatar = account.getAvatar();
            }
            
            if(!userName.equals(account.getUserName())){
                 isUsernameTaken = userDao.isUsernameAvailable(userName);
            }
            if(!email.equals(account.getEmail())){
                isEmailTaken = userDao.isUsernameAvailable(email);
            }
            if (isUsernameTaken && isEmailTaken) {
                account.setUserName(userName);
                boolean updateSuccessful = userDao.updateAccount(account.getUser_ID(), userName, gender, email, mobileNum, avatar);
                userDTO newCount = new userDTO(account.getUser_ID(), userName, avatar, gender, email, mobileNum, account.isStatus(),account.isRoleID(), avatar);
                if (updateSuccessful) {
                    session.setAttribute("USER_NAME", newCount);
                    // Redirect to a success page or display a success message
                    response.sendRedirect(url);
                } else {
                    // Handle the case where the update was not successful
                    response.sendRedirect("error.jsp");
                }
            } else {
                if (!isUsernameTaken) {
                    request.setAttribute("isUsernameTaken", isUsernameTaken);
                    request.getRequestDispatcher(url).forward(request, response);
                } else if (!isEmailTaken) {
                    request.setAttribute("isEmailTaken", isEmailTaken);
                    request.getRequestDispatcher(url).forward(request, response);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (NamingException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
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
