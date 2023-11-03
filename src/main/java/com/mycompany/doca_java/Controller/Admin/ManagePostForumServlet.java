/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.doca_java.Controller.Admin;

import com.mycompany.doca_java.DAO.NotificationDAO;
import com.mycompany.doca_java.DAO.PostDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ManagePostForumServlet", urlPatterns = {"/ManagePostForumServlet"})
public class ManagePostForumServlet extends HttpServlet {

    private final String AdminMangePost = "AdminManageForumPostServlet";
    private final String Error = "Error.html";
    private final String statusApprove = "approved";
    private final String statusReject = "rejected";
    private final String messageReject = "Bài viết bị từ chối vì: ";
    private final String messageApprove = "Bài viết đã được duyệt.";

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
        String url = Error;
        LocalDateTime currentDateTime = LocalDateTime.now();
        Timestamp timeNotification = Timestamp.valueOf(currentDateTime);

        NotificationDAO notiDao = new NotificationDAO();
        boolean resultInsNotifi;
        String setStatus = "";
        try {

            String reason = null;
            String postId = request.getParameter("postId");
            String status = request.getParameter("status");
            String postDes = request.getParameter("postDes");

            String first80Chars = postDes.substring(0, Math.min(postDes.length(), 80));
            String noDes = "";
            //chi lay 15 ky tu tu chuoi
            if (status.equals("approve")) {
                setStatus = statusApprove;
                noDes = messageApprove + "-" + first80Chars + "...";
                resultInsNotifi = notiDao.insertNotification(2, noDes, timeNotification);

            } else {
                setStatus = statusReject;
                reason = request.getParameter("reasonSelect");
                noDes = messageReject + reason + "-" + first80Chars + "...";
                resultInsNotifi = notiDao.insertNotification(2, noDes, timeNotification);
            }

            PostDAO dao = new PostDAO();
            boolean result = dao.setStatusPostForumByAdmin(Integer.parseInt(postId), status, reason);
            if (result && resultInsNotifi) {
                url = AdminMangePost;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        } catch (NamingException ex) {
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
