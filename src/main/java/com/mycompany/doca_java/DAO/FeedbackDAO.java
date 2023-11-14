/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.doca_java.DAO;

import com.mycompany.doca_java.DTO.FeedbackDTO;
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
public class FeedbackDAO {

    private List<FeedbackDTO> ListOfFeedback;

    public List<FeedbackDTO> getListOfConversation() {
        return ListOfFeedback;
    }

    public boolean createFeedback(FeedbackDTO feedback) throws SQLException, ClassNotFoundException, NamingException {
        boolean feedbackExists = isFeedbackExists(feedback.getSeller_id(), feedback.getBuyer_id(),feedback.getProduct_id());
        boolean result=false;
        if (!feedbackExists) {
            Connection con = null;
            PreparedStatement stm = null;
            ResultSet rs = null;
           
            try {
                con = DBconnect.makeConnection();
                if (con != null) {
                    // Create SQL string for inserting a new message
                    String sql = "INSERT INTO [dbo].[feedback] ([seller_id], [buyer_id], [feedback_content], [rate], [product_id])\n"
                            + "VALUES (?, ?, ?, ?, ?)";
                    // Create PreparedStatement object
                    stm = con.prepareStatement(sql);
                    // Set the values for the parameters
                    stm.setInt(1, feedback.getSeller_id());
                    stm.setInt(2, feedback.getBuyer_id());
                    stm.setString(3, feedback.getFeedback_content());
                    stm.setDouble(4, feedback.getRate());
                    stm.setInt(5, feedback.getProduct_id());

                    // Execute the SQL query
                    stm.executeUpdate();
                    result=true;
                }
            } finally {
                // Close the resources
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
        return  result;
    }

   public boolean isFeedbackExists(int sellerId, int buyerId, int productId) throws SQLException, ClassNotFoundException, NamingException {
    Connection con = null;
    PreparedStatement stm = null;
    ResultSet rs = null;
    boolean exists = false;
    
    try {
        con = DBconnect.makeConnection();
        if (con != null) {
            // Create SQL string to check if the feedback exists
            String sql = "SELECT COUNT(*) AS count FROM [dbo].[feedback] WHERE [seller_id] = ? AND [buyer_id] = ? AND [product_id] = ?";
            stm = con.prepareStatement(sql);
            stm.setInt(1, sellerId);
            stm.setInt(2, buyerId);
            stm.setInt(3, productId);

            // Execute the SQL query
            rs = stm.executeQuery();

            // Check if the feedback exists
            if (rs.next()) {
                int count = rs.getInt("count");
                exists = (count > 0);
            }
        }
    } finally {
        // Close the resources
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
    
    return exists;
}

    public double getAverageRateBySellerId(int sellerId) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        double averageRate = 0.0;

        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                // Create SQL string for calculating average rate
                String sql = "SELECT AVG(rate) AS average_rate FROM feedback WHERE seller_id = ?";
                // Create PreparedStatement object
                stm = con.prepareStatement(sql);
                // Set the value for the parameter
                stm.setInt(1, sellerId);

                // Execute the SQL query
                rs = stm.executeQuery();

                // Retrieve the average rate from the result set
                if (rs.next()) {
                    averageRate = rs.getDouble("average_rate");
                }
            }
        } finally {
            // Close the resources
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

        return averageRate;
    }

    public int getFeedbackCountBySellerId(int sellerId) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int feedbackCount = 0;

        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                // Create SQL string for counting feedback records
                String sql = "SELECT COUNT(*) AS feedback_count FROM feedback WHERE seller_id = ?";
                // Create PreparedStatement object
                stm = con.prepareStatement(sql);
                // Set the value for the parameter
                stm.setInt(1, sellerId);
                // Execute the SQL query
                rs = stm.executeQuery();
                // Retrieve the feedback count from the result set
                if (rs.next()) {
                    feedbackCount = rs.getInt("feedback_count");
                }
            }
        } finally {
            // Close the resources
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

        return feedbackCount;
    }

    public List<FeedbackDTO> getListFeedbackBySellerId(int sellerId) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<FeedbackDTO> feedbackList = new ArrayList<>();
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                // Create SQL string for retrieving feedback records by seller ID
                String sql = "SELECT * FROM feedback WHERE seller_id = ?";
                // Create PreparedStatement object
                stm = con.prepareStatement(sql);
                // Set the value for the parameter
                stm.setInt(1, sellerId);
                // Execute the SQL query
                rs = stm.executeQuery();
                // Retrieve feedback records from the result set and populate the feedbackList
                while (rs.next()) {
                    FeedbackDTO feedback = new FeedbackDTO();
                    feedback.setSeller_id(rs.getInt("seller_id"));
                    feedback.setBuyer_id(rs.getInt("buyer_id"));
                    feedback.setFeedback_content(rs.getString("feedback_content"));
                    feedback.setRate(rs.getInt("rate"));
                    feedback.setProduct_id(rs.getInt("product_id"));
                    feedbackList.add(feedback);
                }
            }
        } finally {
            // Close the resources
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

        return feedbackList;
    }

}
