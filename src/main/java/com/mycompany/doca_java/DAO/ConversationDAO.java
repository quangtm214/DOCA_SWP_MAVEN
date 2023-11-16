/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.doca_java.DAO;

import com.mycompany.doca_java.DTO.ConversationDTO;
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
public class ConversationDAO {

    private List<ConversationDTO> ListOfConversation;

    public List<ConversationDTO> getListOfConversation() {
        return ListOfConversation;
    }

    public void getListTheConversationByUserID(int user_id) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                //2.create sql string
                String sql = "SELECT [conversation_id], [product_id], [buyer_id], [seller_id], [status]\n"
                        + "FROM [dbo].[conversation]\n"
                        + "WHERE [buyer_id] = ? OR [seller_id] = ?\n"
                        + "ORDER BY [conversation_id] DESC";

                //3.create stm obj
                stm = con.prepareStatement(sql);
                stm.setInt(1, user_id);
                stm.setInt(2, user_id);
                //4.execute
                rs = stm.executeQuery();
                //5.process (Note: Luu y Khi SU DUNG IF/WHILE)
                while (rs.next()) {
                    int conversation_id = rs.getInt("conversation_id");
                    int product_id = rs.getInt("product_id");
                    int buyer_id = rs.getInt("buyer_id");
                    int seller_id = rs.getInt("seller_id");
                    String status = rs.getString("status");
                    ConversationDTO conversation = new ConversationDTO(conversation_id, product_id, buyer_id, seller_id, status);
                    if (this.ListOfConversation
                            == null) {
                        this.ListOfConversation = new ArrayList<>();
                    }
                    this.ListOfConversation.add(conversation);
                }
            }
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

    public boolean insertConversation(ConversationDTO conversationDTO) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        boolean result = false;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                //check if the conversation have exited
                String checkExistenceSql = "SELECT COUNT(*) AS count FROM [dbo].[conversation] WHERE [product_id] = ? AND [buyer_id] = ? AND [seller_id] = ?";

                stm = con.prepareStatement(checkExistenceSql);
                stm.setInt(1, conversationDTO.getProduct_id());
                stm.setInt(2, conversationDTO.getBuyer_id());
                stm.setInt(3, conversationDTO.getSeller_id());

                rs = stm.executeQuery();
                rs.next();
                int count = rs.getInt("count");

                if (count == 0) {
                    String insertSql = "INSERT INTO [dbo].[conversation] ([product_id], [buyer_id], [seller_id], [status]) VALUES (?, ?, ?, ?)";

                    stm = con.prepareStatement(insertSql);
                    stm.setInt(1, conversationDTO.getProduct_id());
                    stm.setInt(2, conversationDTO.getBuyer_id());
                    stm.setInt(3, conversationDTO.getSeller_id());
                    stm.setString(4, "waiting");

                    stm.executeUpdate();
                    result = true;
                } else {
                    result = false;
                    System.out.println("Conversation already exists with the same product_id, buyer_id, and seller_id.");
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
        return result;
    }

    public List<ConversationDTO> getListTheConversationByProductID(int productID) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ConversationDTO> listOfConversation = new ArrayList<>();
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                // Tạo câu SQL
                String sql = "SELECT [conversation_id], [product_id], [buyer_id], [seller_id], [status]\n"
                        + "FROM [dbo].[conversation]\n"
                        + "WHERE [product_id] = ?\n"
                        + "ORDER BY [conversation_id] DESC";

                stm = con.prepareStatement(sql);
                stm.setInt(1, productID);

                rs = stm.executeQuery();

                while (rs.next()) {
                    int conversation_id = rs.getInt("conversation_id");
                    int buyer_id = rs.getInt("buyer_id");
                    int seller_id = rs.getInt("seller_id");
                    String status = rs.getString("status");
                    ConversationDTO conversation = new ConversationDTO(conversation_id, productID, buyer_id, seller_id, status);
                    listOfConversation.add(conversation);
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
        return listOfConversation;
    }

    public ConversationDTO getOldConversation(int productID, int buyerID, int sellerID) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ConversationDTO conversation = null;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String sql = "SELECT [conversation_id], [product_id], [buyer_id], [seller_id], [status]\n"
                        + "FROM [dbo].[conversation]\n"
                        + "WHERE [product_id] = ? AND ([buyer_id] = ? OR [seller_id] = ?)";

                stm = con.prepareStatement(sql);
                stm.setInt(1, productID);
                stm.setInt(2, buyerID);
                stm.setInt(3, sellerID);

                rs = stm.executeQuery();

                if (rs.next()) {
                    int conversation_id = rs.getInt("conversation_id");
                    int product_id = rs.getInt("product_id");
                    int buyer_id = rs.getInt("buyer_id");
                    int seller_id = rs.getInt("seller_id");
                    String status = rs.getString("status");

                    conversation = new ConversationDTO(conversation_id, product_id, buyer_id, seller_id, status);
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
        return conversation;
    }

    public void updateStatusToApprove(int productID, int buyerID) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String updateSql = "UPDATE [dbo].[conversation] SET [status] = 'approve' WHERE [product_id] = ? AND [buyer_id] = ?";
                stm = con.prepareStatement(updateSql);
                stm.setInt(1, productID);
                stm.setInt(2, buyerID);

                stm.executeUpdate();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

}
