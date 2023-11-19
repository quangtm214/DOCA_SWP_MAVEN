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
                            = new CelanderAdminDTO(rs.getInt("staff_Id"), rs.getInt("shift_Id"), rs.getDate("date"), rs.getString("shiftCategory"), rs.getString("status"), rs.getTime("timeStart"), rs.getTime("timeEnd"));
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
                    near = new CelanderAdminDTO(rs.getInt("staff_Id"), rs.getInt("shift_Id"), rs.getDate("date"), rs.getString("shiftCategory"), rs.getString("status"), rs.getTime("timeStart"), rs.getTime("timeEnd"));
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

}
