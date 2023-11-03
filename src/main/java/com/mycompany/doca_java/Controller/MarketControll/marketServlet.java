/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.doca_java.Controller.MarketControll;

import com.mycompany.doca_java.DAO.ProductDAO;
import com.mycompany.doca_java.DAO.saveProductDAO;
import com.mycompany.doca_java.DTO.ProductDTO;
import com.mycompany.doca_java.DTO.saveProductDTO;
import com.mycompany.doca_java.DTO.userDTO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.AbstractList;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author Admin
 */
@WebServlet(name = "marketServlet", urlPatterns = {"/marketServlet"})
public class marketServlet extends HttpServlet {

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
        userDTO user = (userDTO) session.getAttribute("USER_NAME");
        String index = request.getParameter("index");
        if (index == null) {
            index = "1";
        }
        int indexPage = Integer.parseInt(index);
        String url = "";
        try {
            ProductDAO dao = new ProductDAO();
            
            List<ProductDTO> listOfProduct = (AbstractList<ProductDTO>) session.getAttribute("listOfProduct");
            if (listOfProduct == null) {
                dao.getProductavailable();
                listOfProduct = dao.getListOfProduct();
            }
            if (listOfProduct != null) {
                int numberPage = dao.getNumberPage(listOfProduct);
                List<ProductDTO> listInPage = dao.getPaging(indexPage, listOfProduct);
                request.setAttribute("listOfProduct", listOfProduct);
                request.setAttribute("numberPage", numberPage);
                request.setAttribute("listInPage", listInPage);
                session.setAttribute("indexPageMarket", indexPage);
                url = MARKET_PAGE;
            }
            if (user != null) {
                saveProductDAO saveProductDao = new saveProductDAO();
                int userID = user.getUser_ID();
                saveProductDao.getSaveProductByuserID(userID);
                List<saveProductDTO> listOfSaveProduct = saveProductDao.getListOfSaveProduct();
                if (listOfSaveProduct != null) {
                    session.setAttribute("listOfSaveProduct", listOfSaveProduct);
                }
            }

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
