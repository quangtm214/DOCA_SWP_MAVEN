/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.doca_java.DAO;

import com.mycompany.doca_java.DTO.userDTO;
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
public class userDAO {

    private List<userDTO> ListOfUser;

    public List<userDTO> getListOfUser() {
        return ListOfUser;
    }

    public userDTO checkLogin(String username, String password)
            throws SQLException, NamingException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        userDTO result = null;
        try {
            //1.make connection
            con = DBconnect.makeConnection();
            if (con != null) {
                //2.create sql string
                String sql = "SELECT [user_id]\n"
                        + "      ,[Gender]\n"
                        + "      ,[email]\n"
                        + "      ,[mobile_num]\n"
                        + "      ,[status]\n"
                        + "      ,[role_id]\n"
                        + "      ,[avatar]\n"
                        + "FROM [dbo].[users]\n"
                        + "WHERE [username] = ? AND [password] = ?;";
                //3.create stm obj
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                stm.setString(2, password);
                //4.execute
                rs = stm.executeQuery();
                //5.process (Note: Luu y Khi SU DUNG IF/WHILE)
                if (rs.next()) {
//                    result = true;
                    //map:get data from ResultSet & set data to property's DTO
                    int user_ID = rs.getInt("user_id");
                    String Gender = rs.getString("Gender").trim();
                    String email = rs.getString("email");
                    String phone = rs.getString("mobile_num");
                    boolean status = rs.getBoolean("status");
                    boolean roleID = rs.getBoolean("role_id");
                    String avatar = rs.getString("avatar");
                    result = new userDTO(user_ID, username, password, Gender, email, phone, status, roleID, avatar);
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

    public void getAllTheUser() throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                //2.create sql string
                String sql = "SELECT [user_id], [username], [password], [Gender], [email], [mobile_num], [status], [role_id], [avatar]\n"
                        + "FROM [DOCA_platform].[dbo].[users];";
                //3.create stm obj
                stm = con.prepareStatement(sql);
                //4.execute
                rs = stm.executeQuery();
                //5.process (Note: Luu y Khi SU DUNG IF/WHILE)
                while (rs.next()) {

                    int user_ID = rs.getInt("user_id");
                    String userName = rs.getString("username");
                    String password = rs.getString("password");
                    String Gender = rs.getString("Gender").trim();
                    String email = rs.getString("email");
                    String phone = rs.getString("mobile_num");
                    boolean status = rs.getBoolean("status");
                    boolean roleID = rs.getBoolean("role_id");
                    String avatar = rs.getString("avatar");
                    //5.1.2 set properties of pro
                    userDTO user
                            = new userDTO(user_ID, userName, password, Gender, email, phone, status, roleID, avatar);

                    //5.2 add data to list
                    if (this.ListOfUser
                            == null) {
                        this.ListOfUser = new ArrayList<>();

                    }//end account list has not existed
                    if (user.isRoleID()) {
                        this.ListOfUser.add(user);
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

    public userDTO getUserbyProductID(int productID)
            throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        userDTO user = null;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                //2.create sql string
                String sql = "SELECT u.[user_id], u.[username], u.[password], u.[Gender], u.[email], u.[mobile_num], u.[status], u.[role_id], u.[avatar]\n"
                        + "FROM [DOCA_platform].[dbo].[users] u\n"
                        + "INNER JOIN [DOCA_platform].[dbo].[product] p ON u.[user_id] = p.[user_id]\n"
                        + "WHERE p.[product_id] = ?";
                //3.create stm obj
                stm = con.prepareStatement(sql);
                stm.setInt(1, productID);
                //4.execute
                rs = stm.executeQuery();
                //5.process (Note: Luu y Khi SU DUNG IF/WHILE)
                while (rs.next()) {

                    int user_ID = rs.getInt("user_id");
                    String userName = rs.getString("username");
                    String password = rs.getString("password");
                    String Gender = rs.getString("Gender").trim();
                    String email = rs.getString("email");
                    String phone = rs.getString("mobile_num");
                    boolean status = rs.getBoolean("status");
                    boolean roleID = rs.getBoolean("role_id");
                    String avatar = rs.getString("avatar");
                    //5.1.2 set properties of pro
                    user
                            = new userDTO(user_ID, userName, password, Gender, email, phone, status, roleID, avatar);

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
        return user;
    }

    public boolean createUser(userDTO user) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO users ([username], "
                        + "[password], "
                        + "[Gender], "
                        + "[email], "
                        + "[mobile_num], "
                        + "[status], "
                        + "[role_id], "
                        + "[avatar]) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                ps = con.prepareStatement(sql);
                ps.setString(1, user.getUserName());
                ps.setString(2, user.getPassword());
                ps.setString(3, user.getGender());
                ps.setString(4, user.getEmail());
                ps.setString(5, user.getMobileNum());
                ps.setBoolean(6, user.isStatus());
                ps.setBoolean(7, user.isRoleID());
                ps.setString(8, user.getAvatar());
                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    return true;
                }
            }
        } finally {
            if (ps != null) {
                con.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public boolean isUsernameAvailable(String username) throws SQLException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        boolean result = true;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, username);
                rs = ps.executeQuery();
                if (rs.next()) {
                    int count = rs.getInt(1);
                    if (count > 0) {
                        result = false;
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException | NamingException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }

            if (ps != null) {
                con.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return result;
    }

    public boolean isEmailAvailable(String email) throws SQLException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        boolean result = true;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, email);
                rs = ps.executeQuery();
                if (rs.next()) {
                    int count = rs.getInt(1);
                    if (count > 0) {
                        result = false;
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException | NamingException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }

            if (ps != null) {
                con.close();
            }
            if (con != null) {
                con.close();
            }
        }

        return result; // Return false in case of an error
    }

    public userDTO getUserbyPostID(int postID)
            throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        userDTO user = null;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                //2.create sql string
                String sql = "SELECT u.[user_id], u.[username], u.[password], u.[Gender], u.[email], u.[mobile_num], u.[status], u.[role_id], u.[avatar]\n"
                        + "FROM [DOCA_platform].[dbo].[users] u\n"
                        + "INNER JOIN [DOCA_platform].[dbo].[post] po ON u.[user_id] = po.[user_id]\n"
                        + "WHERE po.[post_id] = ?";
                //3.create stm obj
                stm = con.prepareStatement(sql);
                stm.setInt(1, postID);
                //4.execute
                rs = stm.executeQuery();
                //5.process (Note: Luu y Khi SU DUNG IF/WHILE)
                while (rs.next()) {

                    int user_ID = rs.getInt("user_id");
                    String userName = rs.getString("username");
                    String password = rs.getString("password");
                    String Gender = rs.getString("Gender").trim();
                    String email = rs.getString("email");
                    String phone = rs.getString("mobile_num");
                    boolean status = rs.getBoolean("status");
                    boolean roleID = rs.getBoolean("role_id");
                    String avatar = rs.getString("avatar");
                    //5.1.2 set properties of pro
                    user
                            = new userDTO(user_ID, userName, password, Gender, email, phone, status, roleID, avatar);

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
        return user;
    }

    public userDTO getUserbyUserID(int userID) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        userDTO user = null;

        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String sql = "SELECT [user_id], [username], [password], [Gender], [email], [mobile_num], [status], [role_id], [avatar] "
                        + "FROM [DOCA_platform].[dbo].[users] "
                        + "WHERE [user_id] = ?";

                stm = con.prepareStatement(sql);
                stm.setInt(1, userID);
                rs = stm.executeQuery();

                while (rs.next()) {
                    int user_ID = rs.getInt("user_id");
                    String userName = rs.getString("username");
                    String password = rs.getString("password");
                    String Gender = rs.getString("Gender").trim();
                    String email = rs.getString("email");
                    String phone = rs.getString("mobile_num");
                    boolean status = rs.getBoolean("status");
                    boolean roleID = rs.getBoolean("role_id");
                    String avatar = rs.getString("avatar");

                    user = new userDTO(user_ID, userName, password, Gender, email, phone, status, roleID, avatar);
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
        return user;
    }

    public boolean updateAccount(int user_ID, String userName, String gender, String email, String mobileNum, String avatar)
            throws SQLException, NamingException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            // 1. Make the database connection
            con = DBconnect.makeConnection();

            if (con != null) {

                String sql = "UPDATE dbo.users SET "
                        + "username = ?, "
                        + "Gender = ?, "
                        + "email = ?, "
                        + "mobile_num = ?, "
                        + "avatar = ? "
                        + "WHERE user_id = ?";

                stm = con.prepareStatement(sql);
                stm.setString(1, userName);
                stm.setString(2, gender);
                stm.setString(3, email);
                stm.setString(4, mobileNum);
                stm.setString(5, avatar);
                stm.setInt(6, user_ID);

                int rowsUpdated = stm.executeUpdate();

                if (rowsUpdated > 0) {
                    return true;
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
        return false;
    }

    public boolean updatePassword(int user_ID, String password)
            throws SQLException, NamingException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            // 1. Make the database connection
            con = DBconnect.makeConnection();

            if (con != null) {

                String sql = "UPDATE dbo.users SET "
                        + "password = ? "
                        + "WHERE user_id = ?";

                stm = con.prepareStatement(sql);
                stm.setString(1, password);
                stm.setInt(2, user_ID);

                int rowsUpdated = stm.executeUpdate();

                if (rowsUpdated > 0) {
                    return true;
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
        return false;
    }

    public userDTO getUserByEmail(String email) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        userDTO user = null;

        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String sql = "SELECT * FROM [DOCA_platform].[dbo].[users] WHERE email = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, email);
                rs = stm.executeQuery();

                if (rs.next()) {
                    int user_ID = rs.getInt("user_id");
                    String userName = rs.getString("username");
                    String password = rs.getString("password");
                    String gender = rs.getString("Gender");
                    String userEmail = rs.getString("email");
                    String phone = rs.getString("mobile_num");
                    boolean status = rs.getBoolean("status");
                    boolean roleID = rs.getBoolean("role_id");
                    String avatar = rs.getString("avatar");

                    user = new userDTO(user_ID, userName, password, gender, userEmail, phone, status, roleID, avatar);
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

        return user;
    }

    public List<userDTO> getUsersByRoleIdTrue(int index) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<userDTO> users = new ArrayList<>();

        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String sql = "SELECT [user_id], [username], [password], [Gender], [email], [mobile_num], [status], [role_id], [avatar] "
                        + "FROM [DOCA_platform].[dbo].[users] "
                        + "WHERE [role_id] = 1 "
                        + "ORDER BY [user_id] OFFSET ? ROWS FETCH NEXT 6 ROWS ONLY";

                stm = con.prepareStatement(sql);
                stm.setInt(1, (index - 1) * 6);

                rs = stm.executeQuery();

                while (rs.next()) {
                    int user_ID = rs.getInt("user_id");
                    String userName = rs.getString("username");
                    String password = rs.getString("password");
                    String Gender = rs.getString("Gender");
                    String email = rs.getString("email");
                    String phone = rs.getString("mobile_num");
                    boolean status = rs.getBoolean("status");
                    boolean roleID = rs.getBoolean("role_id");
                    String avatar = rs.getString("avatar");

                    userDTO user = new userDTO(user_ID, userName, password, Gender, email, phone, status, roleID, avatar);
                    users.add(user);
                }
            }
        } finally {
            // Close resources
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
        return users;
    }

    public boolean banUser(int userId) throws SQLException, NamingException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = DBconnect.makeConnection(); // Replace with your database connection method
            if (con != null) {
                String sql = "UPDATE users SET status = ? WHERE user_id = ?"; // Corrected SQL statement
                stm = con.prepareStatement(sql);
                stm.setString(1, "false"); // Assuming "BANNED" is the status you want to set
                stm.setInt(2, userId);
                int rowsAffected = stm.executeUpdate();

                if (rowsAffected > 0) {
                    // Update was successful
                    return true;
                } else {
                    // No user found with the given user_id, or the update had no effect
                    return false;
                }
            } else {
                // Handle connection error
                throw new SQLException("Database connection is not established.");
            }
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    public boolean unbanUser(int userId) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String sql = "UPDATE users SET status = ? WHERE user_id = ?";
                stm = con.prepareStatement(sql);

                // Set status to true (unbanned)
                stm.setBoolean(1, true);
                stm.setInt(2, userId);

                int rowsAffected = stm.executeUpdate();

                return rowsAffected > 0;
            } else {
                throw new SQLException("Database connection is not established.");
            }
        } finally {
            // Close resources
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public List<userDTO> searchByUsername(String username) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<userDTO> userList = new ArrayList<>();

        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String sql = "SELECT [user_id], [username], [password], [Gender], [email], [mobile_num], [status], [role_id], [avatar]\n"
                        + "FROM [DOCA_platform].[dbo].[users]\n"
                        + "WHERE [username] LIKE ?;";
                stm = con.prepareStatement(sql);
                stm.setString(1, "%" + username + "%"); // Use '%' as a wildcard for a partial match

                rs = stm.executeQuery();

                while (rs.next()) {
                    int user_ID = rs.getInt("user_id");
                    String userName = rs.getString("username");
                    String password = rs.getString("password");
                    String Gender = rs.getString("Gender");
                    String email = rs.getString("email");
                    String phone = rs.getString("mobile_num");
                    boolean status = rs.getBoolean("status");
                    boolean roleID = rs.getBoolean("role_id");
                    String avatar = rs.getString("avatar");

                    userDTO user = new userDTO(user_ID, userName, password, Gender, email, phone, status, roleID, avatar);

                    if (this.ListOfUser == null) {
                        this.ListOfUser = new ArrayList<>();
                    }

                    if (user.isRoleID()) {
                        this.ListOfUser.add(user);
                    }
                }
            }
        } finally {
            // Close resources
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

        return ListOfUser;
    }

    public List<userDTO> getRankUserInForum(String status) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<userDTO> userList = new ArrayList<>();

        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String sql = "SELECT TOP 5 [post].[user_id], [users].[username], [users].[avatar], COUNT(*) AS post_count\n"
                        + "FROM [dbo].[post]\n"
                        + "JOIN [dbo].[users] ON [post].[user_id] = [users].[user_id]\n"
                        + "WHERE [post].[status] = ? "
                        + "      AND MONTH([post].[timePosted]) = MONTH(GETDATE())\n"
                        + "      AND YEAR([post].[timePosted]) = YEAR(GETDATE())\n"
                        + "      AND [users].[status] = 1\n"
                        + "GROUP BY [post].[user_id], [users].[username], [users].[avatar]\n"
                        + "ORDER BY post_count DESC";
                stm = con.prepareStatement(sql);
                stm.setString(1, status); // Use '%' as a wildcard for a partial match

                rs = stm.executeQuery();

                while (rs.next()) {
                    int user_ID = rs.getInt("user_id");
                    String userName = rs.getString("username");
                    String avatar = rs.getString("avatar");
                    int countPost = rs.getInt("post_count");
                    userDTO dto = new userDTO(user_ID, userName, avatar, countPost);
                    userList.add(dto);
                }
            }
        } finally {
            // Close resources
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

        return userList;
    }

    public List<userDTO> getRankUserBySales() throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<userDTO> userList = new ArrayList<>();

        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String sql = "SELECT TOP 5 [users].[user_id], [users].[username], [users].[avatar], COUNT(*) AS sales_count\n"
                        + "FROM [dbo].[conversation]\n"
                        + "JOIN [dbo].[users] ON [conversation].[seller_id] = [users].[user_id]\n"
                        + "WHERE [conversation].[status] = 'complete'\n"
                        + "GROUP BY [users].[user_id], [users].[username], [users].[avatar]\n"
                        + "ORDER BY sales_count DESC";
                stm = con.prepareStatement(sql);

                rs = stm.executeQuery();

                while (rs.next()) {
                    int userID = rs.getInt("user_id");
                    String userName = rs.getString("username");
                    String avatar = rs.getString("avatar");
                    int salesCount = rs.getInt("sales_count");
                    userDTO dto = new userDTO(userID, userName, avatar, salesCount);
                    userList.add(dto);
                }
            }
        } finally {
            // Close resources
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

        return userList;
    }

    public List<userDTO> getRankUserByTotalLikes() throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<userDTO> userList = new ArrayList<>();

        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String sql = "SELECT TOP 5 [post].[user_id], [users].[username], [users].[avatar], SUM([like].[like_count]) AS total_likes\n"
                        + "FROM [dbo].[post]\n"
                        + "JOIN [dbo].[users] ON [post].[user_id] = [users].[user_id]\n"
                        + "LEFT JOIN (\n"
                        + "    SELECT [post_id], COUNT(*) AS like_count\n"
                        + "    FROM [dbo].[like]\n"
                        + "    GROUP BY [post_id]\n"
                        + ") AS [like] ON [post].[post_id] = [like].[post_id]\n"
                        + "GROUP BY [post].[user_id], [users].[username], [users].[avatar]\n"
                        + "ORDER BY total_likes DESC";
                stm = con.prepareStatement(sql);

                rs = stm.executeQuery();

                while (rs.next()) {
                    int userID = rs.getInt("user_id");
                    String userName = rs.getString("username");
                    String avatar = rs.getString("avatar");
                    int totalLikes = rs.getInt("total_likes");
                    userDTO dto = new userDTO(userID, userName, avatar, totalLikes);
                    userList.add(dto);
                }
            }
        } finally {
            // Close resources
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

        return userList;
    }

    public int countUsersWithRoleIdTrue() throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int userCount = 0;

        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String sql = "SELECT COUNT(*) AS userCount FROM [DOCA_platform].[dbo].[users] WHERE role_id = 1";
                stm = con.prepareStatement(sql);

                rs = stm.executeQuery();

                if (rs.next()) {
                    userCount = rs.getInt("userCount");
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

        return userCount;
    }

    public int countSearch(String txtSearch) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBconnect.makeConnection();

            if (con != null) {
                String sql = "SELECT COUNT(*) AS total FROM users WHERE username LIKE ? AND role_id <> 0";
                stm = con.prepareStatement(sql);

                stm.setString(1, "%" + txtSearch + "%");

                rs = stm.executeQuery();

                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        } finally {
            // Close resources (ResultSet, PreparedStatement, and Connection)
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

        return 0;
    }

    public List<userDTO> searchByUsername(String username, int index) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<userDTO> userList = new ArrayList<>();

        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                String sql = "SELECT [user_id], [username], [password], [Gender], [email], [mobile_num], [status], [role_id], [avatar]\n"
                        + "FROM [DOCA_platform].[dbo].[users]\n"
                        + "WHERE [username] LIKE ?\n"
                        + "ORDER BY [user_id] OFFSET ? ROWS FETCH NEXT 6 ROWS ONLY;";  // Assuming you want to fetch 6 records per page
                stm = con.prepareStatement(sql);
                stm.setString(1, "%" + username + "%"); // Use '%' as a wildcard for a partial match
                stm.setInt(2, (index - 1) * 6); // Assuming 6 records per page and index starting from 1

                rs = stm.executeQuery();

                while (rs.next()) {
                    int user_ID = rs.getInt("user_id");
                    String userName = rs.getString("username");
                    String password = rs.getString("password");
                    String Gender = rs.getString("Gender");
                    String email = rs.getString("email");
                    String phone = rs.getString("mobile_num");
                    boolean status = rs.getBoolean("status");
                    boolean roleID = rs.getBoolean("role_id");
                    String avatar = rs.getString("avatar");

                    userDTO user = new userDTO(user_ID, userName, password, Gender, email, phone, status, roleID, avatar);

                    if (this.ListOfUser == null) {
                        this.ListOfUser = new ArrayList<>();
                    }

                    if (user.isRoleID()) {
                        this.ListOfUser.add(user);
                    }
                }
            }
        } finally {
            // Close resources
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

        return ListOfUser;
    }

    public List<userDTO> getUsersByRoleID(int roleID) throws SQLException, ClassNotFoundException, NamingException {
        List<userDTO> userList = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                // Create the SQL query string with a parameter for roleID
                String sql = "SELECT [user_id], [username], [password], [Gender], [email], [mobile_num], [status], [role_id], [avatar]\n"
                        + "FROM [DOCA_platform].[dbo].[users]\n"
                        + "WHERE [role_id] = ?";

                // Create the prepared statement and set the roleID parameter
                stm = con.prepareStatement(sql);
                stm.setInt(1, roleID);

                // Execute the query
                rs = stm.executeQuery();

                // Process the results
                while (rs.next()) {
                    int user_ID = rs.getInt("user_id");
                    String userName = rs.getString("username");
                    String password = rs.getString("password");
                    String gender = rs.getString("Gender").trim();
                    String email = rs.getString("email");
                    String phone = rs.getString("mobile_num");
                    boolean status = rs.getBoolean("status");
                    boolean role_ID = rs.getBoolean("role_id");
                    String avatar = rs.getString("avatar");

                    userDTO user = new userDTO(user_ID, userName, password, gender, email, phone, status, role_ID, avatar);

                    // Add the user to the list
                    userList.add(user);
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

        return userList;
    }
}
