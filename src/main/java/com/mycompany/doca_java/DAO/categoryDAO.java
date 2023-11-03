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
    
    
    
    
}
