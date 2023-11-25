/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.doca_java.DAO;

import com.mycompany.doca_java.DTO.categoryDTO;
import com.mycompany.doca_java.util.DBconnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author Admin
 */
public class categoryDAO {

    public categoryDTO getCategoryById(int categoryID)
            throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        categoryDTO category = null;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {

                String sql = "SELECT [category_id], [category_name]\n"
                        + "FROM [DOCA_platform].[dbo].[category]\n"
                        + "WHERE [category_id] = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, categoryID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String categoryName = rs.getString("category_name");
                    category = new categoryDTO(categoryID, categoryName);
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

        return category;
    }

    public List<categoryDTO> getCountPostByCategory() throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List< categoryDTO> listCount = new ArrayList<>();
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                //2.create sql string
                String sql = "SELECT clp.category_id, c.category_name, COUNT(clp.post_id) AS post_count\n"
                        + "FROM categoryLinkpost clp\n"
                        + "INNER JOIN category c ON clp.category_id = c.category_id\n"
                        + "GROUP BY clp.category_id, c.category_name;";
                //3.create stm obj
                stm = con.prepareStatement(sql);
                //4.execute
                rs = stm.executeQuery();
                //5.process (Note: Luu y Khi SU DUNG IF/WHILE)
                while (rs.next()) {
                    categoryDTO dto = new categoryDTO(rs.getInt("category_id"), rs.getString("category_name"), rs.getInt("post_count"));
                    listCount.add(dto);
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
        return listCount;
    }

    public List<categoryDTO> getCountProductByCategory() throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List< categoryDTO> listCount = new ArrayList<>();
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                //2.create sql string
                String sql = "SELECT c.category_id, c.category_name, COALESCE(p.post_count, 0) AS post_count\n"
                        + "FROM category c\n"
                        + " JOIN (\n"
                        + "    SELECT category_id, COUNT(*) AS post_count\n"
                        + "    FROM product\n"
                        + "    GROUP BY category_id\n"
                        + ") p ON c.category_id = p.category_id;";
                //3.create stm obj
                stm = con.prepareStatement(sql);
                //4.execute
                rs = stm.executeQuery();
                //5.process (Note: Luu y Khi SU DUNG IF/WHILE)
                while (rs.next()) {
                    categoryDTO dto = new categoryDTO(rs.getInt("category_id"), rs.getString("category_name"), rs.getInt("post_count"));
                    listCount.add(dto);
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
        return listCount;
    }
}
