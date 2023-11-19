/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.doca_java.Controller.loginSignup;

import com.mycompany.doca_java.DAO.CalendarAdminDAO;
import com.mycompany.doca_java.DTO.CelanderAdminDTO;
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
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;

/**
 *
 * @author Admin
 */
@WebServlet(name = "calendarStaffServlet", urlPatterns = {"/calendarStaffServlet"})
public class calendarStaffServlet extends HttpServlet {

    private final String Admin_page = "AdminManageForumPostServlet";
    private final String Erro = "login.jsp";

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
        String url = "";
        try {
            response.setContentType("text/html;charset=UTF-8");

            HttpSession session = request.getSession(true);
            userDTO admin = (userDTO) session.getAttribute("USER_NAME");

            LocalDate currentDate = LocalDate.now();
            // Định dạng ngày theo kiểu "YYYY-MM-DD"
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            String formattedDate = currentDate.format(formatter);
            Date dateNow = Date.valueOf(formattedDate);

            CalendarAdminDAO dao = new CalendarAdminDAO();
            List<CelanderAdminDTO> listCale = dao.getAllCalendarAdById(admin.getUser_ID(), dateNow);
            // Giờ hiện tại
            LocalTime currentTime = LocalTime.now();

            boolean foundShift = false; // Thêm biến foundShift

            if (listCale != null) {
                for (CelanderAdminDTO shift : listCale) {
                    Time startTime = shift.getStartTime();
                    Time endTime = shift.getEndTime();

                    // Chuyển đổi sang kiểu LocalTime
                    LocalTime localStartTime = startTime.toLocalTime();
                    LocalTime localEndTime = endTime.toLocalTime();
                    // So sánh giờ hiện tại với khoảng giờ startTime và endTime
                    if (currentTime.isAfter(localStartTime) && currentTime.isBefore(localEndTime)) {
                        request.setAttribute("messShift", "Ca làm việc: " + localStartTime + "-" + localEndTime);
                        url = Admin_page;
                        foundShift = true; // Đặt foundShift thành true nếu tìm thấy ca làm việc
                        break;
                    }
                }
            }

            // Kiểm tra foundShift và thực hiện xử lý tương ứng
            if (!foundShift) {
                // Xử lý khi không tìm thấy ca làm việc phù hợp
//                CelanderAdminDTO shiftNear = dao.getNearShiftAdById(admin.getUser_ID(), dateNow);
                request.setAttribute("messnotShift",
                        "Chưa đến ca làm của bạn.");
                //+ "Ca làm việc của bạn sẽ bắt đầu lúc : " + shiftNear.getStartTime() + "-" + shiftNear.getEndTime() + " /Ngày: " + shiftNear.getDate()
                url = Erro;
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(calendarStaffServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(calendarStaffServlet.class.getName()).log(Level.SEVERE, null, ex);
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
