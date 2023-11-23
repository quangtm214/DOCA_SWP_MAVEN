/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.doca_java.Controller.Admin;

import com.mycompany.doca_java.DAO.CalendarAdminDAO;
import com.mycompany.doca_java.DTO.dateDTO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author Admin
 */
@WebServlet(name = "setupAdminCelander", urlPatterns = {"/setupAdminCelander"})
public class setupAdminCelander extends HttpServlet {

    private final String MangeDateInWeek = "MangeDateInWeek";

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
        ServletContext context = getServletContext();
        List<dateDTO> listDateInWeek = (List<dateDTO>) context.getAttribute("listDateInWeek");
        String url = "";
        try {
            CalendarAdminDAO cDao = new CalendarAdminDAO();
            String selectedWeek = (String) context.getAttribute("lastSelectedWeek");
            url = "MangeDateInWeek?selectedWeek=" + selectedWeek;
            for (dateDTO date : listDateInWeek) {
                String dateIn = date.getDate().toString();
                String adminSlot1Param = request.getParameter("Slot1_" + dateIn);
                String adminSlot2Param = request.getParameter("Slot2_" + dateIn);
                String adminSlot3Param = request.getParameter("Slot3_" + dateIn);

                int Adminslot1 = 0;
                int Adminslot2 = 0;
                int Adminslot3 = 0;

                if (adminSlot1Param != null && !adminSlot1Param.isEmpty()) {
                    Adminslot1 = Integer.parseInt(adminSlot1Param);
                }
                if (adminSlot2Param != null && !adminSlot2Param.isEmpty()) {
                    Adminslot2 = Integer.parseInt(adminSlot2Param);
                }
                if (adminSlot3Param != null && !adminSlot3Param.isEmpty()) {
                    Adminslot3 = Integer.parseInt(adminSlot3Param);
                }

                for (int i = 1; i < 4; i++) {
                    int shiftID = cDao.getShiftIdByDateAndShift(Date.valueOf(date.getDate()), i);
                    switch (i) {
                        case 1:
                            if (Adminslot1 != 0) {
                                cDao.insertCalendarAdmin(Adminslot1, shiftID);
                            }
                            break;
                        case 2:
                            if (Adminslot2 != 0) {
                                cDao.insertCalendarAdmin(Adminslot2, shiftID);
                            }
                            break;
                        case 3:
                            if (Adminslot3 != 0) {
                                cDao.insertCalendarAdmin(Adminslot3, shiftID);
                            }
                            break;
                        default:
                            // Code for other cases (if applicable)
                            break;
                    }
                }
            }
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
