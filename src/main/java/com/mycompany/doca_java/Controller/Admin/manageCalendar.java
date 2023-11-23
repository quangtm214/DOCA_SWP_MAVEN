/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.doca_java.Controller.Admin;

import com.mycompany.doca_java.DAO.dateDAO;
import com.mycompany.doca_java.DAO.userDAO;
import com.mycompany.doca_java.DAO.weekDAO;
import com.mycompany.doca_java.DTO.dateDTO;
import com.mycompany.doca_java.DTO.userDTO;
import com.mycompany.doca_java.DTO.weekDTO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author Admin
 */
@WebServlet(name = "manageCalendar", urlPatterns = {"/manageCalendar"})
public class manageCalendar extends HttpServlet {

    private final String manageCelendarJsp = "AdminUI/manageCelendar.jsp";

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
        ServletContext context = getServletContext();
        String url="";
        try {
            weekDAO wDao = new weekDAO();
            LocalDate currentDate = java.time.LocalDate.now();
            wDao.getAllTheWeek();
            List<weekDTO> ListOfWeek = wDao.getListOfWeek();
            for (weekDTO week : ListOfWeek) {
                if (currentDate.isAfter(week.getStartDate()) && currentDate.isBefore(week.getEndDate())) {
                    String selectedWeek= week.getStartDate()+"/"+week.getEndDate();
                    url="MangeDateInWeek?selectedWeek="+selectedWeek;
//                    LocalDate inWeek = week.getStartDate();
//                    dateDAO dDao = new dateDAO();
//                    List<dateDTO> listDateInWeek = dDao.getWeeksInRange(week.getStartDate(), week.getEndDate());
//                    if (listDateInWeek != null) {
//                        context.setAttribute("listDateInWeek", listDateInWeek);
//                    }
//                    request.setAttribute("inWeek", inWeek.toString());
                }
            }
            userDAO udao = new userDAO();
            List<userDTO> listAdmin = udao.getUsersByRoleID(0);
            session.setAttribute("listAdmin", listAdmin);
            session.setAttribute("ListOfWeek", ListOfWeek);
            // session.setAttribute("currentDate", currentDate);
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        } catch (NamingException ex) {
            ex.printStackTrace();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            RequestDispatcher dispatcher = request.getRequestDispatcher(url);
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
