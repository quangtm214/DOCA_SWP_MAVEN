/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.doca_java.DAO;

import com.mycompany.doca_java.DTO.ProductDTO;
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
public class ProductDAO {

    private List<ProductDTO> ListOfProduct;

    public List<ProductDTO> getListOfProduct() {
        return ListOfProduct;
    }

    public void getAllTheProduct() throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                //2.create sql string
                String sql = "SELECT product_id, user_id, category_id, title, description, product_image, is_free, price, address, timePosted, isPublic, status, reason "
                        + "FROM product "
                        + "ORDER BY timePosted DESC"; // Sắp xếp giảm dần timePosted
                //3.create stm obj
                stm = con.prepareStatement(sql);
                //4.execute
                rs = stm.executeQuery();
                //5.process (Note: Luu y Khi SU DUNG IF/WHILE)
                while (rs.next()) {
                    int productId = rs.getInt("product_id");
                    int userId = rs.getInt("user_id");
                    int categoryId = rs.getInt("category_id");
                    String title = rs.getString("title");
                    String description = rs.getString("description");
                    String productImage = rs.getString("product_image");
                    boolean isFree = rs.getBoolean("is_free");
                    float price = rs.getFloat("price");
                    String address = rs.getString("address");
                    Timestamp timePosted = rs.getTimestamp("timePosted");
                    boolean isPublic = rs.getBoolean("isPublic");
                    String status = rs.getString("status");
                    String reason = rs.getString("reason");

                    //5.1.2 set properties of pro
                    ProductDTO product = new ProductDTO(productId, userId, categoryId, title, description, productImage, isFree, price, address, timePosted, isPublic, status, reason);

                    //5.2 add data to list
                    if (this.ListOfProduct == null) {
                        this.ListOfProduct = new ArrayList<>();
                    }//end account list has not existed

                    this.ListOfProduct.add(product);
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

    public void getProductavailable() throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                //2.create sql string
                String sql = "SELECT product_id, user_id, category_id, title, description, product_image, is_free, price, address, timePosted, isPublic, status, reason "
                        + "FROM product "
                        + "ORDER BY timePosted DESC"; // Sắp xếp giảm dần timePosted
                //3.create stm obj
                stm = con.prepareStatement(sql);
                //4.execute
                rs = stm.executeQuery();
                //5.process (Note: Luu y Khi SU DUNG IF/WHILE)
                while (rs.next()) {
                    int productId = rs.getInt("product_id");
                    int userId = rs.getInt("user_id");
                    int categoryId = rs.getInt("category_id");
                    String title = rs.getString("title");
                    String description = rs.getString("description");
                    String productImage = rs.getString("product_image");
                    boolean isFree = rs.getBoolean("is_free");
                    float price = rs.getFloat("price");
                    String address = rs.getString("address");
                    Timestamp timePosted = rs.getTimestamp("timePosted");
                    boolean isPublic = rs.getBoolean("isPublic");
                    String status = rs.getString("status");
                    String reason = rs.getString("reason");

                    //5.1.2 set properties of pro
                    ProductDTO product = new ProductDTO(productId, userId, categoryId, title, description, productImage, isFree, price, address, timePosted, isPublic, status, reason);

                    //5.2 add data to list
                    if (this.ListOfProduct == null) {
                        this.ListOfProduct = new ArrayList<>();
                    }//end account list has not existed
                    if (product.isPublic() && (product.getStatus().equals("approved"))) {
                        this.ListOfProduct.add(product);
                    }
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

    public ProductDTO getProductById(int productId)
            throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ProductDTO product = null;

        try {
            con = DBconnect.makeConnection();
            if (con != null) {

                String sql = "SELECT product_id, user_id, category_id, title, description, product_image, is_free, price, address, timePosted, isPublic, status, reason "
                        + "FROM product WHERE product_id = ?";

                stm = con.prepareStatement(sql);
                stm.setInt(1, productId);
                rs = stm.executeQuery();
                if (rs.next()) {
                    int userId = rs.getInt("user_id");
                    int categoryId = rs.getInt("category_id");
                    String title = rs.getString("title");
                    String description = rs.getString("description");
                    String productImage = rs.getString("product_image");
                    boolean isFree = rs.getBoolean("is_free");
                    float price = rs.getFloat("price");
                    String address = rs.getString("address");
                    Timestamp timePosted = rs.getTimestamp("timePosted");
                    boolean isPublic = rs.getBoolean("isPublic");
                    String status = rs.getString("status");
                    String reason = rs.getString("reason");
                    product = new ProductDTO(productId, userId, categoryId, title, description, productImage, isFree, price, address, timePosted, isPublic, status, reason);
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

        return product;
    }

    public void getProductSavedbyUserID(int userID) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                //2.create sql string
                String sql = "SELECT p.[product_id], p.[user_id], p.[category_id], p.[title], p.[description], p.[product_image], p.[is_free], p.[price], p.[address], p.[timePosted], p.[isPublic], p.[status], p.[reason]\n"
                        + "FROM [DOCA_platform].[dbo].[product] p\n"
                        + "INNER JOIN [DOCA_platform].[dbo].[saveProduct] s ON p.[product_id] = s.[product_id]\n"
                        + "WHERE s.[user_id] = ?";
                //3.create stm obj
                stm = con.prepareStatement(sql);
                stm.setInt(1, userID);
                //4.execute
                rs = stm.executeQuery();
                //5.process (Note: Luu y Khi SU DUNG IF/WHILE)
                while (rs.next()) {
                    int productId = rs.getInt("product_id");
                    int userId = rs.getInt("user_id");
                    int categoryId = rs.getInt("category_id");
                    String title = rs.getString("title");
                    String description = rs.getString("description");
                    String productImage = rs.getString("product_image");
                    boolean isFree = rs.getBoolean("is_free");
                    float price = rs.getFloat("price");
                    String address = rs.getString("address");
                    Timestamp timePosted = rs.getTimestamp("timePosted");
                    boolean isPublic = rs.getBoolean("isPublic");
                    String status = rs.getString("status");
                    String reason = rs.getString("reason");

                    //5.1.2 set properties of pro
                    ProductDTO product = new ProductDTO(productId, userId, categoryId, title, description,
                            productImage, isFree, price, address, timePosted, isPublic, status, reason);

                    //5.2 add data to list
                    if (this.ListOfProduct
                            == null) {
                        this.ListOfProduct = new ArrayList<>();

                    }//end account list has not existed
                    if (product.isPublic()) {
                        this.ListOfProduct.add(product);
                    }
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

    public List<ProductDTO> getProductsByUserId(int userId) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ProductDTO> productList = new ArrayList<>();
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String sql = "SELECT product_id, user_id, category_id, title, description, product_image, is_free, price, address, timePosted, isPublic, status, reason "
                        + "FROM product "
                        + "WHERE user_id = ? "
                        + "ORDER BY timePosted DESC";
                stm = con.prepareStatement(sql);
                stm.setInt(1, userId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int productId = rs.getInt("product_id");
                    int categoryId = rs.getInt("category_id");
                    String title = rs.getString("title");
                    String description = rs.getString("description");
                    String productImage = rs.getString("product_image");
                    boolean isFree = rs.getBoolean("is_free");
                    float price = rs.getFloat("price");
                    String address = rs.getString("address");
                    Timestamp timePosted = rs.getTimestamp("timePosted");
                    boolean isPublic = rs.getBoolean("isPublic");
                    String status = rs.getString("status");
                    String reason = rs.getString("reason");

                    ProductDTO product = new ProductDTO(productId, userId, categoryId, title, description, productImage, isFree, price, address, timePosted, isPublic, status, reason);
                    productList.add(product);
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
        return productList;
    }

    public List<ProductDTO> getProductsOtherUser(int userId) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ProductDTO> productList = new ArrayList<>();
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String sql = "SELECT product_id, user_id, category_id, title, description, product_image, is_free, price, address, timePosted, isPublic, status, reason "
                        + "FROM product "
                        + "WHERE user_id = ? "
                        + "ORDER BY timePosted DESC";
                stm = con.prepareStatement(sql);
                stm.setInt(1, userId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int productId = rs.getInt("product_id");
                    int categoryId = rs.getInt("category_id");
                    String title = rs.getString("title");
                    String description = rs.getString("description");
                    String productImage = rs.getString("product_image");
                    boolean isFree = rs.getBoolean("is_free");
                    float price = rs.getFloat("price");
                    String address = rs.getString("address");
                    Timestamp timePosted = rs.getTimestamp("timePosted");
                    boolean isPublic = rs.getBoolean("isPublic");
                    String status = rs.getString("status");
                    String reason = rs.getString("reason");

                    ProductDTO product = new ProductDTO(productId, userId, categoryId, title, description, productImage, isFree, price, address, timePosted, isPublic, status, reason);
                    if (product.isPublic() && (product.getStatus().equals("approved"))) {
                        productList.add(product);
                    }
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
        return productList;
    }

    public List<ProductDTO> searchByProductTitle(String title) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ProductDTO> productList = new ArrayList<>();
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String sql = "SELECT product_id, user_id, category_id, title, description, product_image, is_free, price, address, timePosted, isPublic, status, reason "
                        + "FROM product "
                        + "WHERE title LIKE ? "
                        + "ORDER BY timePosted DESC";
                stm = con.prepareStatement(sql);
                stm.setString(1, "%" + title + "%");
                rs = stm.executeQuery();
                while (rs.next()) {
                    int productId = rs.getInt("product_id");
                    int userId = rs.getInt("user_id");
                    int categoryId = rs.getInt("category_id");
                    String productTitle = rs.getString("title");
                    String description = rs.getString("description");
                    String productImage = rs.getString("product_image");
                    boolean isFree = rs.getBoolean("is_free");
                    float price = rs.getFloat("price");
                    String address = rs.getString("address");
                    Timestamp timePosted = rs.getTimestamp("timePosted");
                    boolean isPublic = rs.getBoolean("isPublic");
                    String status = rs.getString("status");
                    String reason = rs.getString("reason");
                    ProductDTO product = new ProductDTO(productId, userId, categoryId, productTitle, description, productImage, isFree, price, address, timePosted, isPublic, status, reason);
                    if (product.isPublic() && (product.getStatus().equals("approved"))) {
                        productList.add(product);
                    }

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
        return productList;
    }

    public int getNumberPage(List<ProductDTO> ListOfProduct) {
        int totalProduct = ListOfProduct.size();
        if (totalProduct > 0) {
            int countPage = totalProduct / 5;
            if (totalProduct % 5 != 0) {
                countPage++;
            }
            return countPage;
        }
        return 0;
    }

    public List<ProductDTO> getPaging(int index, List<ProductDTO> ListOfProduct) {
        int start = (index - 1) * 5;
        int end = Math.min(start + 5, ListOfProduct.size());
        List<ProductDTO> listInPage = new ArrayList<>();
        for (int i = start; i < end; i++) {
            listInPage.add(ListOfProduct.get(i));
        }
        return listInPage;
    }

    public boolean createPostProduct(ProductDTO product) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        boolean result = false;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO product (user_id, category_id, title, description, product_image, is_free, price, address, timePosted, isPublic, status, reason) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                stm = con.prepareStatement(sql);
                stm.setInt(1, product.getUserId());
                stm.setInt(2, product.getCategoryId());
                stm.setString(3, product.getTitle());
                stm.setString(4, product.getDescription());
                stm.setString(5, product.getProductImage());
                stm.setBoolean(6, product.isFree());
                stm.setDouble(7, product.getPrice());
                stm.setString(8, product.getAddress());
                stm.setTimestamp(9, product.getTimePosted());
                stm.setBoolean(10, product.isPublic());
                stm.setString(11, product.getStatus());
                stm.setString(12, product.getReason());

                // Execute the query
                int rowsAffected = stm.executeUpdate();
                if (rowsAffected > 0) {
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

    public boolean updateProduct(ProductDTO product) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        boolean result = false;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String sql = "UPDATE product SET category_id = ?, title = ?, description = ?, product_image = ?, is_free = ?, price = ?, address = ?, timePosted = ?, isPublic = ?, status = ?, reason = ? WHERE product_id = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, product.getCategoryId());
                stm.setString(2, product.getTitle());
                stm.setString(3, product.getDescription());
                stm.setString(4, product.getProductImage());
                stm.setBoolean(5, product.isFree());
                stm.setDouble(6, product.getPrice());
                stm.setString(7, product.getAddress());
                stm.setTimestamp(8, product.getTimePosted());
                stm.setBoolean(9, product.isPublic());
                stm.setString(10, product.getStatus());
                stm.setString(11, product.getReason());
                stm.setInt(12, product.getProductId());

                // Execute the query
                int rowsAffected = stm.executeUpdate();
                if (rowsAffected > 0) {
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

    public boolean deleteProduct(int productId) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        boolean result = false;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String sql = "DELETE FROM product WHERE product_id = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, productId);

                // Execute the query
                int rowsAffected = stm.executeUpdate();
                if (rowsAffected > 0) {
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

    public boolean updateIsPublic(int productId, boolean isPublic) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        boolean result = false;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String sql = "UPDATE product SET isPublic = ? WHERE product_id = ?";
                stm = con.prepareStatement(sql);
                stm.setBoolean(1, isPublic);
                stm.setInt(2, productId);

                // Execute the query
                int rowsAffected = stm.executeUpdate();
                if (rowsAffected > 0) {
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

    private List<ProductDTO> ListProductByStatus;

    public List<ProductDTO> getListProductByStatus() {
        return ListProductByStatus;
    }

    public void getProductsbyStatus(String statusNow) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                //2.create sql string
                String sql = "SELECT [product_id]\n"
                        + "      ,[user_id]\n"
                        + "      ,[category_id]\n"
                        + "      ,[title]\n"
                        + "      ,[description]\n"
                        + "      ,[product_image]\n"
                        + "      ,[is_free]\n"
                        + "      ,[price]\n"
                        + "      ,[address]\n"
                        + "      ,[timePosted]\n"
                        + "      ,[isPublic]\n"
                        + "      ,[status]\n"
                        + "      ,[reason]\n"
                        + "  FROM [dbo].[product]" + " Where status =? ";
                //3.create stm obj
                stm = con.prepareStatement(sql);
                stm.setString(1, statusNow);
                //4.execute
                rs = stm.executeQuery();
                //5.process (Note: Luu y Khi SU DUNG IF/WHILE)
                while (rs.next()) {
                    int productId = rs.getInt("product_id");
                    int userId = rs.getInt("user_id");
                    int categoryId = rs.getInt("category_id");
                    String title = rs.getString("title");
                    String description = rs.getString("description");
                    String productImage = rs.getString("product_image");
                    boolean isFree = rs.getBoolean("is_free");
                    float price = rs.getFloat("price");
                    String address = rs.getString("address");
                    Timestamp timePosted = rs.getTimestamp("timePosted");
                    boolean isPublic = rs.getBoolean("isPublic");
                    String status = rs.getString("status");
                    String reason = rs.getString("reason");

                    //5.1.2 set properties of pro
                    ProductDTO product = new ProductDTO(productId, userId, categoryId, title, description, productImage, isFree, price, address, (Timestamp) timePosted, isPublic, status, reason);

                    //5.2 add data to list
                    if (this.ListProductByStatus
                            == null) {
                        this.ListProductByStatus = new ArrayList<>();

                    }//end account list has not existed

                    this.ListProductByStatus.add(product);
                }//end map DB to DTO
            }//end connect is available
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
    }

    public boolean setStatusProductPostByAdmin(String productId, String status, String reason) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;

        boolean result = false;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String sql = "UPDATE product "
                        + "SET status = ?, reason = ? "
                        + "WHERE product_id = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, status);
                stm.setString(2, reason);
                stm.setString(3, productId);
                int effectRows = stm.executeUpdate();
                //5.Process
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
}
