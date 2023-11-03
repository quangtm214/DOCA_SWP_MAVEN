/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.doca_java.DAO;

import com.mycompany.doca_java.DTO.NotificationDTO;
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
public class NotificationDAO {

    public List<NotificationDTO> getListNotification(int userId) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<NotificationDTO> listOfPosts = new ArrayList<>();

        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                // Create SQL query
                String sql = "SELECT [notification_id]\n"
                        + "      ,[user_id]\n"
                        + "      ,[notification_value]\n"
                        + "      ,[time]\n"
                        + "  FROM [dbo].[notification] "
                        + " Where user_id = ? ";
                // Create prepared statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, userId);
                // Execute query
                rs = stm.executeQuery();
                // Process the result set
                while (rs.next()) {
                    NotificationDTO dto = new NotificationDTO(rs.getInt("user_id"), rs.getString("notification_value"), rs.getTimestamp("time"));
                    listOfPosts.add(dto);
                }
                return listOfPosts;
            }
        } finally {
            // Close resources in the finally block
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

        return listOfPosts;
    }

    public boolean insertNotification(int userId, String notificationValue, Timestamp time) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;

        boolean result = false;
        try {
            //1. make connection 
            con = DBconnect.makeConnection();
            if (con != null) {
                //2.create sql String
                String sql = "INSERT INTO [dbo].[notification] ([user_id], [notification_value], [time]) VALUES (?, ? , ?)";
                //3.create stm obj
                stm = con.prepareStatement(sql);
                stm.setInt(1, userId);
                stm.setString(2, notificationValue);
                stm.setTimestamp(3, time);
                //4.execute
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
