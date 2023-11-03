/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.doca_java.Controller.MarketControll;

import com.mycompany.doca_java.DAO.ProductDAO;
import com.mycompany.doca_java.DTO.ProductDTO;
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
@WebServlet(name = "filterProduct", urlPatterns = {"/filterProduct"})
public class filterProduct extends HttpServlet {

    private final String MARKET_PAGE = "market.jsp";

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
        String url = "";
        String local = request.getParameter("city") != null ? request.getParameter("city") : "";
        float lowerPrice = request.getParameter("lowerPrice") != null ? Float.parseFloat(request.getParameter("lowerPrice")) : 0.0f;
        int category = request.getParameter("category") != null ? Integer.parseInt(request.getParameter("category")) : 0;

        String index = request.getParameter("indexFromSaveProduct");
        if (index == null) {
            index = "1";
        }
        int indexPage = Integer.parseInt(index);

        try {
            List<ProductDTO> listOfProduct = new ArrayList<>();
            listOfProduct=(AbstractList<ProductDTO>) session.getAttribute("listOfProductSearch");
            if(listOfProduct==null){
            ProductDAO dao = new ProductDAO();
            dao.getProductavailable();
            listOfProduct = dao.getListOfProduct();
            }
            List<ProductDTO> newListOfProduct = new ArrayList<>();
            for (ProductDTO product : listOfProduct) {
                if ((local.isEmpty() || product.getAddress().contains(local))
                        && (lowerPrice == 0 || product.getPrice() <= lowerPrice)
                        && (category == 0 || product.getCategoryId() == category)) {
                    newListOfProduct.add(product);
                }
            }
            session.setAttribute("listOfProduct", newListOfProduct);
            session.setAttribute("selectedLocal", local);
            session.setAttribute("selectedLowerPrice", lowerPrice);
            session.setAttribute("selectedCategory", category);
            url = "marketServlet?index=" + indexPage;

        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        } catch (NamingException ex) {
            ex.printStackTrace();
        } catch (SQLException ex) {
            ex.printStackTrace();
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
