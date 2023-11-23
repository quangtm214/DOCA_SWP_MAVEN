/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.doca_java.DAO;

import com.mycompany.doca_java.DTO.CelanderAdminDTO;
import com.mycompany.doca_java.util.DBconnect;
import java.sql.Connection;
import java.sql.Date;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author Admin
 */
public class CalendarAdminDAO {

    public List<CelanderAdminDTO> getAllCalendarAdById(int staff_Id, Date date) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<CelanderAdminDTO> listCelander = new ArrayList<>();

        try {
            con = DBconnect.makeConnection();

            if (con != null) {
                // Create SQL query
                String sql = "SELECT ca.staff_Id , ca.shift_Id, cd.date,  cd.status , s.shiftCategory,s.timeStart, s.timeEnd \n"
                        + "FROM calendarAdmin ca\n"
                        + "LEFT JOIN calendarDetail cd ON ca.shift_Id = cd.shift_Id\n"
                        + "LEFT JOIN shift s ON s.shiftCategory = cd.shift\n"
                        + "WHERE cd.date = ? AND ca.staff_Id = ?;";
                // Create prepared statement
                stm = con.prepareStatement(sql);
                stm.setDate(1, date);
                stm.setInt(2, staff_Id);
                // Execute query
                rs = stm.executeQuery();
                // Process the result set

                while (rs.next()) {
                    CelanderAdminDTO dto
                            = new CelanderAdminDTO(rs.getInt("staff_Id"), rs.getInt("shift_Id"), rs.getDate("date").toLocalDate(), rs.getString("shiftCategory"), rs.getString("status"), rs.getTime("timeStart"), rs.getTime("timeEnd"));
                    listCelander.add(dto);
                }

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

        return listCelander;

    }

    public CelanderAdminDTO getNearShiftAdById(int staff_Id, Date date) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        CelanderAdminDTO near = null;

        try {
            con = DBconnect.makeConnection();

            if (con != null) {
                // Create SQL query
                String sql = "SELECT ca.staff_Id, ca.shift_Id, cd.date, cd.status, s.shiftCategory, s.timeStart, s.timeEnd\n"
                        + "FROM calendarAdmin ca\n"
                        + "LEFT JOIN calendarDetail cd ON ca.shift_Id = cd.shift_Id\n"
                        + "LEFT JOIN shift s ON s.shiftCategory = cd.shift\n"
                        + "WHERE cd.date >= ? \n and staff_Id = ?"
                        + "ORDER BY ABS(DATEDIFF(cd.date, ?)) ASC\n"
                        + "LIMIT 1;";
                // Create prepared statement
                stm = con.prepareStatement(sql);
                stm.setDate(1, date);
                stm.setInt(2, staff_Id);

                // Execute query
                rs = stm.executeQuery();
                // Process the result set

                while (rs.next()) {
                    near = new CelanderAdminDTO(rs.getInt("staff_Id"), rs.getInt("shift_Id"), rs.getDate("date").toLocalDate(), rs.getString("shiftCategory"), rs.getString("status"), rs.getTime("timeStart"), rs.getTime("timeEnd"));
                }

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

        return near;

    }

    public List<CelanderAdminDTO> getAllCalendarAdBetweenDates(LocalDate startOfWeek, LocalDate endOfWeek) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<CelanderAdminDTO> listCelander = new ArrayList<>();

        try {
            con = DBconnect.makeConnection();

            if (con != null) {
                // Create SQL query
                String sql = "SELECT ca.staff_Id, ca.shift_Id, cd.date, cd.status, s.shiftCategory, s.timeStart, s.timeEnd \n"
                        + "FROM calendarAdmin ca\n"
                        + "LEFT JOIN calendarDetail cd ON ca.shift_Id = cd.shift_Id\n"
                        + "LEFT JOIN shift s ON s.shiftCategory = cd.shift\n"
                        + "WHERE cd.date >= ? AND cd.date <= ?;";
                // Create prepared statement
                stm = con.prepareStatement(sql);
                stm.setDate(1, java.sql.Date.valueOf(startOfWeek));
                stm.setDate(2, java.sql.Date.valueOf(endOfWeek));
                // Execute query
                rs = stm.executeQuery();
                // Process the result set
                while (rs.next()) {
                    CelanderAdminDTO dto = new CelanderAdminDTO(
                            rs.getInt("staff_Id"),
                            rs.getInt("shift_Id"),
                            rs.getDate("date").toLocalDate(),
                            rs.getString("shiftCategory"),
                            rs.getString("status"),
                            rs.getTime("timeStart"),
                            rs.getTime("timeEnd")
                    );
                    listCelander.add(dto);
                }
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

        return listCelander;
    }

    public int getShiftIdByDateAndShift(Date date, int shift) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int shiftId = -1;

        try {
            con = DBconnect.makeConnection();

            if (con != null) {
                // Create SQL query
                String sql = "SELECT [shift_Id] FROM [dbo].[calendarDetail] WHERE [date] = ? AND [shift] = ?";

                // Create prepared statement
                stm = con.prepareStatement(sql);
                stm.setDate(1, date);
                stm.setInt(2, shift);

                // Execute query
                rs = stm.executeQuery();

                // Process the result set
                if (rs.next()) {
                    shiftId = rs.getInt("shift_Id");
                }
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

        return shiftId;
    }

    public void insertCalendarAdmin(int staff_Id, int shift_Id) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = DBconnect.makeConnection();

            if (con != null) {
                // Check if shift_Id exists in calendarAdmin
                String checkSql = "IF EXISTS (SELECT 1 FROM [dbo].[calendarAdmin] WHERE [shift_Id] = ?) "
                        + "UPDATE [dbo].[calendarAdmin] SET [staff_Id] = ? WHERE [shift_Id] = ? "
                        + "ELSE "
                        + "INSERT INTO [dbo].[calendarAdmin] ([staff_Id], [shift_Id]) VALUES (?, ?)";

                stm = con.prepareStatement(checkSql);
                stm.setInt(1, shift_Id);
                stm.setInt(2, staff_Id);
                stm.setInt(3, shift_Id);
                stm.setInt(4, staff_Id);
                stm.setInt(5, shift_Id);

                stm.executeUpdate();
            }
        } finally {
            // Close resources in the finally block
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
}
