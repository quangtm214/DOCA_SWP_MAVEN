/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.doca_java.Controller.ManageOwner.savedProduct;

import com.mycompany.doca_java.DAO.ConversationDAO;
import com.mycompany.doca_java.DAO.NotificationDAO;
import com.mycompany.doca_java.DAO.ProductDAO;
import com.mycompany.doca_java.DAO.saveProductDAO;
import com.mycompany.doca_java.DTO.ProductDTO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
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
import java.util.List;
import java.util.logging.Level;
import javax.naming.NamingException;

/**
 *
 * @author Admin
 */
@WebServlet(name = "confirmSave", urlPatterns = {"/confirmSave"})
public class confirmSave extends HttpServlet {

    private final String statusSaled = "saled";
    private final String statusWating = "waiting";
    private final String statusReject = "reject";
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
        ServletContext context = getServletContext();
        String url = "";
//         LocalDateTime currentDateTime = LocalDateTime.now();
//        Timestamp timeNotification = Timestamp.valueOf(currentDateTime);
        try {
            response.setContentType("text/html;charset=UTF-8");
            String buyerId = request.getParameter("buyerID");
            String productId = request.getParameter("producID");
            saveProductDAO dao = new saveProductDAO();
            ProductDAO pdao = new ProductDAO();
            ConversationDAO cdao = new ConversationDAO();
            boolean result = false;
            if (buyerId != null) {
                result = dao.setMatchProduct(Integer.parseInt(buyerId), Integer.parseInt(productId), statusSaled);
                dao.setStatusSaveProduct(Integer.parseInt(productId), statusWating, statusReject);

                pdao.setStatusProduct(Integer.parseInt(productId), statusSaled);
                cdao.updateStatusToApprove(Integer.parseInt(productId), Integer.parseInt(buyerId));
            } else {
                result = dao.setStatusSaveProduct(Integer.parseInt(productId), statusWating, statusReject);
                pdao.setStatusProduct(Integer.parseInt(productId), statusSaled);
            }
            if (result) {
//                ProductDTO product = pdao.getProductById(Integer.parseInt(productId));
//                String title = product.getTitle();
//                String first80Chars = title.substring(0, Math.min(title.length(), 80));
//                String noDes = "";
//                NotificationDAO notiDao = new NotificationDAO();
//                noDes = "Sản phẩm bạn quan tâm: " + first80Chars + " - " + "Đã được giao dịch với người khác";
//                List<Integer> listUserID = dao.getUserIDsByProductID(Integer.parseInt(productId));
//                for (Integer userID : listUserID) {
//                    if (userID != Integer.parseInt(buyerId)) {
//                        notiDao.insertNotification(userID, noDes, timeNotification);
//                    }
//                }
//                context.setAttribute("MssSaledSuccess", "Xác nhận giao dịch thành công");
                url = GET_CONVERSATIONLIST;
            }

        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        } catch (NamingException ex) {
            ex.printStackTrace();
        } catch (SQLException ex) {
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
