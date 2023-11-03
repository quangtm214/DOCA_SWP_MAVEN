/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.doca_java.Controller.ManageOwner.personal_Product;

import com.mycompany.doca_java.Constant.Folder_Up;
import static com.mycompany.doca_java.Controller.ManageOwner.personal_Product.PostPorductV2.postSucc;
import com.mycompany.doca_java.DAO.ProductDAO;
import com.mycompany.doca_java.DTO.ProductDTO;
import com.mycompany.doca_java.DTO.userDTO;
import com.mycompany.doca_java.ProcessDetails.ProcessImg;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpDate_Product", urlPatterns = {"/UpDate_Product"})
@MultipartConfig
public class UpDate_Product extends HttpServlet {

    private static final long serialVersionUID = 1L;
    public static final String PERSONAL_PRODUCT_PAGE = "getPersonalProduct";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        userDTO account = (userDTO) session.getAttribute("USER_NAME");
        String IN = request.getParameter("IN");
        String url = "";
        try {
            int Productid = Integer.parseInt(request.getParameter("Productid"));
            String categoryPost = request.getParameter("category_Product");
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String price = request.getParameter("fee");
            boolean isFree = true;
            String inputFee = "0";
            if (price != null && price.equals("fee")) {
                inputFee = request.getParameter("input-fee");
                inputFee = inputFee.replaceAll("[^\\d]", "");
                isFree = false;
                // Xử lý giá trị của ô input khi radio button "Tính phí" được chọn
            } else {
                // Xử lý khi radio button "Miễn phí" được chọn hoặc không có radio button nào được chọn
            }
            // Location
            String address = request.getParameter("NewAddress");
            if (address.trim().isEmpty()) {
                address = request.getParameter("OldAddress");
            }
            // Lấy ngày và giờ hiện tại
            LocalDateTime currentDateTime = LocalDateTime.now();
            // Chuyển đổi thành kiểu dữ liệu Timestamp
            Timestamp timePosted = Timestamp.valueOf(currentDateTime);

// Lấy ngày và giờ hiện tại
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss");
            String timestamp = dateFormat.format(new Date());
            String imageUrl = "";
            // Get the uploaded image file from the request
            Part filePart = request.getPart("file");
            if (filePart != null && filePart.getSize() > 0) {
                InputStream fileInputStream = filePart.getInputStream();

                // Upload the image to Cloudinary
                // Process the image using the ImageProcessor class
                ProcessImg imageProcessor = new ProcessImg();
                imageUrl = imageProcessor.uploadImageToFolder(fileInputStream, Folder_Up.FORUM_UP);
            } else {
                imageUrl = request.getParameter("OldImg");
            }

            ProductDAO dao = new ProductDAO();
            ProductDTO product
                    = new ProductDTO(Productid, account.getUser_ID(), Integer.parseInt(categoryPost), title, content, imageUrl,
                            isFree, Float.parseFloat(inputFee), address, timePosted, true, "pending", null);
            boolean result = false;
            result = dao.updateProduct(product);
            if (result == true) {
                request.setAttribute("product", product);
                session.setAttribute("IN", IN);
                url = PERSONAL_PRODUCT_PAGE;
            }

        } catch (SQLException ex) {
            Logger.getLogger(PostPorductV2.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(PostPorductV2.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(PostPorductV2.class.getName()).log(Level.SEVERE, null, ex);
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
