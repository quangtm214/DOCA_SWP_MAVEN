/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.doca_java.Controller;

import com.mycompany.doca_java.DAO.PostDAO;
import com.mycompany.doca_java.DAO.categoryDAO;
import com.mycompany.doca_java.DAO.userDAO;
import com.mycompany.doca_java.DTO.PostDTO;
import com.mycompany.doca_java.DTO.categoryDTO;
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
import java.util.AbstractList;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author Admin
 */
@WebServlet(name = "forumServlet", urlPatterns = {"/forumServlet"})
public class forumServlet extends HttpServlet {

    private final String GET_COMMENT_SERVLET = "getAllCommentServlet";
    private final String GET_LIKE_SERVLET = "getAllLikeServlet";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        String idcate = request.getParameter("categoryID");
        if (idcate == null) {
            idcate = "5";
        }
        int indexcategoryID = Integer.parseInt(idcate);
        String index = request.getParameter("index");
        if (index == null) {
            index = "1";
        }
        int indexPage = Integer.parseInt(index);
        String url = "";
        try {
            PostDAO dao = new PostDAO();
            List<PostDTO> listOfPost = new ArrayList<>();
            listOfPost = (AbstractList<PostDTO>) session.getAttribute("listOfPostSearch");
            if (listOfPost == null) {
                dao.getPostByCategoryID(indexcategoryID);
                listOfPost = dao.getListOfPost();
                int numberPage = dao.getNumberPage(listOfPost);
                List<PostDTO> listInPage = dao.getPaging(indexPage, listOfPost);
                if (listInPage != null) {
                    request.setAttribute("listOfPost", listOfPost);
                    request.setAttribute("indexcategoryID", indexcategoryID);
                    request.setAttribute("listInPage", listInPage);
                    request.setAttribute("numberPage", numberPage);
                    session.setAttribute("indexPageForum", indexPage);
                }
            } else {//if listOfPostSearch hava value it will be filter
                dao.getPostByCategoryID(indexcategoryID);
                List<PostDTO> listOfAllPost = dao.getListOfPost();
                List<PostDTO> listOfSearchPost = new ArrayList<>();;
                for (PostDTO postcate : listOfAllPost) {
                    int count = 0;
                    for (PostDTO postSearch : listOfPost) {
                        if (postSearch.getPostId() == postcate.getPostId()) {
                            count++;
                        }
                    }
                    //nếu phần tử trong list thu được từ search, không nằm trong list thu được
                    //từ lọc Category thì loại ra giữ lại những element thuộc đúng category
                    if (count != 0) {
                        listOfSearchPost.add(postcate);
                    }
                }
                int numberPage = dao.getNumberPage(listOfSearchPost);
                List<PostDTO> listInPage = dao.getPaging(indexPage, listOfSearchPost);
                if (listInPage != null) {
                    request.setAttribute("listOfPost", listOfSearchPost);
                    request.setAttribute("indexcategoryID", indexcategoryID);
                    request.setAttribute("listInPage", listInPage);
                    request.setAttribute("numberPage", numberPage);
                    session.setAttribute("indexPageForum", indexPage);
                }
            }

            categoryDAO cataDao = new categoryDAO();
            List<categoryDTO> listCategory = new ArrayList<>();
            for (int i = 5; i <= 9; i++) {
                listCategory.add(cataDao.getCategoryById(i));
            }
            if (listCategory != null) {
                request.setAttribute("listCategory", listCategory);
            }

            userDAO uDao = new userDAO();
            uDao.getAllTheUser();
            List<userDTO> ListOfUser = uDao.getListOfUser();
            if (ListOfUser != null) {
                request.setAttribute("ListOfUser", ListOfUser);
            }

            url = GET_LIKE_SERVLET;
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        } catch (NamingException ex) {
            ex.printStackTrace();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
//            response.sendRedirect(url);
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
