package com.mycompany.doca_java.Controller.Admin;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import com.mycompany.doca_java.DAO.userDAO;
import com.mycompany.doca_java.DTO.userDTO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.stream.Collectors;
import javax.naming.NamingException;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AllUserServlet", urlPatterns = {"/AllUserServlet"})
public class AllUserServlet extends HttpServlet {

    private final String adminShowUser = "AdminUI/alluser.jsp";

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
        HttpSession session = request.getSession();
        userDTO account = (userDTO) session.getAttribute("USER_NAME");
        String indexPage = request.getParameter("index");
        if (indexPage == null) {
            indexPage = "1";
        }
        int index = Integer.parseInt(indexPage);
        try {
            if (!account.isRoleID()) {
                // Gọi DAO để lấy danh sách người dùng có role_id = true
                userDAO userDAO = new userDAO();
                int countProduct = userDAO.countUsersWithRoleIdTrue();
                int endPage = countProduct / 6;
                if (countProduct % 6 != 0) {
                    endPage++;
                }
                request.setAttribute("endPage", endPage);

                List<userDTO> userList = userDAO.getUsersByRoleIdTrue(index);
                // Đặt danh sách người dùng vào thuộc tính của request
                request.setAttribute("userList", userList);
                session.setAttribute("indexStay", index);
                // Chuyển hướng đến trang JSP để hiển thị thông tin người dùng
            }
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        } catch (NamingException ex) {
            ex.printStackTrace();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            RequestDispatcher dispatcher = request.getRequestDispatcher(adminShowUser);
            dispatcher.forward(request, response);
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
