/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.doca_java.DAO;

import com.mycompany.doca_java.DTO.saveProductDTO;
import com.mycompany.doca_java.util.DBconnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author Admin
 */
public class saveProductDAO {

    private List<saveProductDTO> listOfSaveProduct = new ArrayList<>();

    public List<saveProductDTO> getListOfSaveProduct() {
        return listOfSaveProduct;
    }

    public void getSaveProductByuserID(int userID) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                //2.create sql string
                String sql = "SELECT sp.product_id "
                        + "FROM saveProduct sp "
                        + "JOIN users u ON sp.user_id = u.user_id "
                        + "WHERE u.user_id = ? "
                        + "ORDER BY sp.time DESC";
                //3.create stm obj
                stm = con.prepareStatement(sql);
                stm.setInt(1, userID);
                //4.execute
                rs = stm.executeQuery();
                //5.process (Note: Luu y Khi SU DUNG IF/WHILE)
                while (rs.next()) {
                    int productId = rs.getInt("product_id");
                    //5.1.2 set properties of pro
                    saveProductDTO savedProduct = new saveProductDTO(productId);

                    //5.2 add data to list
                    if (this.listOfSaveProduct
                            == null) {
                        this.listOfSaveProduct = new ArrayList<>();

                    }//end account list has not existed

                    this.listOfSaveProduct.add(savedProduct);
                }//end map DB to DTO
            }//end connect is available
        } finally {
            if (rs != null) {
                rs.close();
            }

            if (stm != null) {
                con.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public List<Integer> getUserIDsByProductID(int productID) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Integer> userIDs = new ArrayList<>();

        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                // Tạo câu truy vấn SQL để lấy danh sách user ID từ product ID
                String sql = "SELECT u.user_id "
                        + "FROM saveProduct sp "
                        + "JOIN users u ON sp.user_id = u.user_id "
                        + "WHERE sp.product_id = ? "
                        + "AND sp.statusMatch NOT IN ('resale', 'unfollow', 'ban') "
                        + "ORDER BY sp.time DESC";
                stm = con.prepareStatement(sql);
                stm.setInt(1, productID);

                rs = stm.executeQuery();

                while (rs.next()) {
                    int userID = rs.getInt("user_id");
                    userIDs.add(userID);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }

        return userIDs;
    }

    public int getCountOfSave(int productID) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int count = 0;

        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                // Tạo câu truy vấn SQL để lấy số lượng lượt quan tâm
                String sql = "SELECT COUNT(*) AS interest_count\n"
                        + "FROM saveProduct\n"
                        + "WHERE product_id = ?\n"
                        + "AND statusMatch NOT IN ('resale', 'unfollow', 'ban', 'reject')";

                stm = con.prepareStatement(sql);
                stm.setInt(1, productID);

                rs = stm.executeQuery();

                if (rs.next()) {
                    count = rs.getInt("interest_count");
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }

        return count;
    }

    public boolean createSaveProduct(int userID, int productId) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        boolean result = false;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                // Check if the pair of userID and productID already exists
                String checkSql = "SELECT COUNT(*) FROM saveProduct WHERE user_id = ? AND product_id = ?";
                PreparedStatement checkStm = con.prepareStatement(checkSql);
                checkStm.setInt(1, userID);
                checkStm.setInt(2, productId);
                ResultSet rs = checkStm.executeQuery();
                rs.next();
                int count = rs.getInt(1);

                if (count == 0) {
                    // If the pair doesn't exist, insert it into the saveProduct table
                    String insertSql = "INSERT INTO saveProduct (user_id, product_id, statusMatch, time) VALUES (?, ?, ?, GETDATE())";
                    stm = con.prepareStatement(insertSql);
                    stm.setInt(1, userID);
                    stm.setInt(2, productId);
                    stm.setString(3, "waiting");

                    int effectRows = stm.executeUpdate();
                    if (effectRows > 0) {
                        result = true;
                    }
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return result;
    }

    public boolean deleteSaveProduct(int userID, int productId) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        boolean result = false;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                // Create SQL statement
                String sql = "UPDATE saveProduct SET statusMatch = 'unfollow', time = GETDATE() WHERE user_id = ? AND product_id = ?";
                // Create prepared statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, userID);
                stm.setInt(2, productId);
                // Execute the deletion
                int effectRows = stm.executeUpdate();
                // Process the result
                if (effectRows > 0) {
                    result = true;
                }
            }
        } finally {
            // Close the statement and connection
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return result;
    }

    public List<saveProductDTO> getAllSaveProduct() throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<saveProductDTO> listOfSaveProduct = new ArrayList<>();
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                // Create SQL statement
                String sql = "SELECT product_id FROM saveProduct";
                // Create prepared statement
                stm = con.prepareStatement(sql);
                // Execute the query
                rs = stm.executeQuery();
                // Process the result
                while (rs.next()) {
                    int productId = rs.getInt("product_id");
                    // Create saveProductDTO object
                    saveProductDTO savedProduct = new saveProductDTO(productId);
                    // Add data to list
                    listOfSaveProduct.add(savedProduct);
                }
            }
        } finally {
            // Close the result set, statement, and connection
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return listOfSaveProduct;
    }

    public boolean setMatchProduct(int userId, int productId, String statusMatch)
            throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        boolean result = false;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                //2.create sql string
                String sql = "UPDATE saveProduct SET statusMatch = ?, time = GETDATE() WHERE product_id = ? AND user_id = ?";
                //3.create stm obj
                stm = con.prepareStatement(sql);
                stm.setString(1, statusMatch);
                stm.setInt(2, productId);
                stm.setInt(3, userId);
                //4.execute
                int effectRows = stm.executeUpdate();
                //5.process (Note: Luu y Khi SU DUNG IF/WHILE)
                if (effectRows > 0) {
                    result = true;
                }
            }//end connect is available
        } finally {
            if (stm != null) {
                con.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return result;
    }

//    public List<Integer> getRejectedSaveProductsByUserID(int userID) throws SQLException, ClassNotFoundException, NamingException {
//        Connection con = null;
//        PreparedStatement stm = null;
//        ResultSet rs = null;
//        List<Integer> rejectedProductIDs = new ArrayList<>();
//
//        try {
//            con = DBconnect.makeConnection();
//            if (con != null) {
//                String sql = "SELECT sp.product_id "
//                        + "FROM saveProduct sp "
//                        + "JOIN users u ON sp.user_id = u.user_id "
//                        + "WHERE u.user_id = ? AND sp.statusMatch = 'reject'"; // Thêm điều kiện statusMatch
//
//                stm = con.prepareStatement(sql);
//                stm.setInt(1, userID);
//
//                rs = stm.executeQuery();
//
//                while (rs.next()) {
//                    int productId = rs.getInt("product_id");
//                    rejectedProductIDs.add(productId);
//                }
//            }
//        } finally {
//            // Đóng tất cả các resource
//            if (rs != null) {
//                rs.close();
//            }
//            if (stm != null) {
//                stm.close();
//            }
//            if (con != null) {
//                con.close();
//            }
//        }
//        return rejectedProductIDs;
//    }
    public boolean setStatusSaveProduct(int productId, String statusNow, String setStatus) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        boolean result = false;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                //2.create sql string
                String sql = "UPDATE [dbo].[saveProduct]\n"
                        + "SET [statusMatch] = ?, [time] = GETDATE()\n"
                        + "WHERE [statusMatch] = ? AND [product_id] = ?";
                //3.create stm obj
                stm = con.prepareStatement(sql);
                stm.setString(1, setStatus);
                stm.setString(2, statusNow);
                stm.setInt(3, productId);
                //4.execute
                int effectRows = stm.executeUpdate();
                //5.process (Note: Luu y Khi SU DUNG IF/WHILE)
                if (effectRows > 0) {
                    result = true;
                }
            }//end connect is available
        } finally {
            if (stm != null) {
                con.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return result;
    }

    public boolean setStatusSaveProductByUID(int userID, int productID, String statusNow, String setStatus) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        boolean result = false;

        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                // Tạo câu truy vấn SQL để cập nhật trạng thái của sản phẩm
                String sql = "UPDATE [dbo].[saveProduct]\n"
                        + "SET [statusMatch] = ?, [time] = GETDATE()\n"
                        + "WHERE [user_id] = ? AND [product_id] = ? AND [statusMatch] = ?";

                stm = con.prepareStatement(sql);
                stm.setString(1, setStatus);
                stm.setInt(2, userID);
                stm.setInt(3, productID);
                stm.setString(4, statusNow);

                int effectRows = stm.executeUpdate();

                if (effectRows > 0) {
                    result = true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }

        return result;
    }

    public List<saveProductDTO> getListSaveProductDTO(int productID) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<saveProductDTO> saveProducts = new ArrayList<>();

        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String sql = "SELECT sp.product_id, sp.user_id, sp.statusMatch, sp.time "
                        + "FROM saveProduct sp "
                        + "WHERE sp.product_id = ? "
                        + "ORDER BY sp.time DESC";

                stm = con.prepareStatement(sql);
                stm.setInt(1, productID);

                rs = stm.executeQuery();

                while (rs.next()) {
                    int userId = rs.getInt("user_id");
                    String statusMatch = rs.getString("statusMatch");
                    Timestamp timeSave = rs.getTimestamp("time");
                    saveProductDTO saveProductDTO = new saveProductDTO(productID, userId, statusMatch,timeSave);
                    saveProducts.add(saveProductDTO);
                }
            }
        } finally {
            // Close all resources
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return saveProducts;
    }

    public List<saveProductDTO> getListSaveProductDTOByUserID(int userID) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<saveProductDTO> saveProducts = new ArrayList<>();

        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String sql = "SELECT sp.product_id, sp.user_id, sp.statusMatch "
                        + "FROM saveProduct sp "
                        + "WHERE sp.user_id = ? "
                        + "ORDER BY sp.time DESC";

                stm = con.prepareStatement(sql);
                stm.setInt(1, userID);

                rs = stm.executeQuery();

                while (rs.next()) {
                    int productId = rs.getInt("product_id");
                    String statusMatch = rs.getString("statusMatch");

                    saveProductDTO saveProductDTO = new saveProductDTO(productId, userID, statusMatch);
                    saveProducts.add(saveProductDTO);
                }
            }
        } finally {
            // Close all resources
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return saveProducts;
    }

}
