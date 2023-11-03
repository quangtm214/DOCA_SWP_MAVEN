/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.doca_java.Controller;

import com.mycompany.doca_java.DAO.PostDAO;
import com.mycompany.doca_java.DAO.categoryDAO;
import com.mycompany.doca_java.DAO.commentDAO;
import com.mycompany.doca_java.DAO.likeDAO;
import com.mycompany.doca_java.DAO.userDAO;
import com.mycompany.doca_java.DTO.PostDTO;
import com.mycompany.doca_java.DTO.categoryDTO;
import com.mycompany.doca_java.DTO.commentDTO;
import com.mycompany.doca_java.DTO.userDTO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author minhluan
 */
@WebServlet(name = "postDetailServlet", urlPatterns = {"/postDetailServlet"})
public class postDetailServlet extends HttpServlet {

    private final String postDetail_Page = "postDetail.jsp";

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
        int postID = Integer.parseInt(request.getParameter("postId"));
        
        String url = "";
        try {
            PostDAO dao = new PostDAO();
            PostDTO postDetail = dao.getPostById(postID);
            userDAO ownerDao = new userDAO();
//            int commentID = Integer.parseInt(request.getParameter("commentId"));
            if (postDetail != null) {
                HttpSession session = request.getSession(true);
                likeDAO likeDao= new likeDAO();
                int likeCount=likeDao.getLikeCountByPostID(postID);
                request.setAttribute("postDetail", postDetail);
                request.setAttribute("likeCount", likeCount);

                commentDAO cdao = new commentDAO();
                cdao.getAllComment();
                List<commentDTO> listOfComment = cdao.getListOfComment();
                if (listOfComment != null) {
                    request.setAttribute("listOfComment", listOfComment);
                }
//                boolean result = cdao.deleteComment(commentID);

                userDTO owner = ownerDao.getUserbyPostID(postID);
                request.setAttribute("owner", owner);
                userDAO uDao = new userDAO();
                uDao.getAllTheUser();
                List<userDTO> ListOfUser = uDao.getListOfUser();
                if (ListOfUser != null) {
                    request.setAttribute("ListOfUser", ListOfUser);
                }

                url = postDetail_Page;

            }
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        } catch (NamingException ex) {
            ex.printStackTrace();
        } catch (SQLException ex) {
            ex.printStackTrace();
//        } catch (NumberFormatException ex) {
//            ex.printStackTrace();
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
