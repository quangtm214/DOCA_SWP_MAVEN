/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.doca_java.DAO;

import com.mycompany.doca_java.DTO.dateDTO;
import com.mycompany.doca_java.util.DBconnect;
import java.sql.Connection;
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
public class dateDAO {

    public List<dateDTO> getWeeksInRange(LocalDate startOfWeek, LocalDate endOfWeek) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<dateDTO> listOfDate= new ArrayList<>();
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                // Create the new SQL query
                String sql = "SELECT [Date], [Day], [DayOfWeek], [DayOfMonth], [DayOfYear], [PreviousDay], [NextDay], [WeekOfYear], "
                        + "[Month], [MonthOfYear], [QuarterOfYear], [Year], [IsWeekend] "
                        + "FROM [dbo].[tblCalendar] "
                        + "WHERE [Date] >= ? AND [Date] <= ?";

                // Create the statement object
                stm = con.prepareStatement(sql);
                stm.setDate(1, java.sql.Date.valueOf(startOfWeek));
                stm.setDate(2, java.sql.Date.valueOf(endOfWeek));

                // Execute the query
                rs = stm.executeQuery();

                // Process the result
                while (rs.next()) {
                    java.sql.Date sqlDate = rs.getDate("Date");
                    if (sqlDate != null) {
                        LocalDate date = sqlDate.toLocalDate();
                        String day = rs.getString("Day");
                        int dayOfWeek = rs.getInt("DayOfWeek");
                        int dayOfMonth = rs.getInt("DayOfMonth");
                        int dayOfYear = rs.getInt("DayOfYear");
                        java.sql.Date sqlPreviousDay = rs.getDate("PreviousDay");
                        java.sql.Date sqlNextDay = rs.getDate("NextDay");
                        LocalDate previousDay = (sqlPreviousDay != null) ? sqlPreviousDay.toLocalDate() : null;
                        LocalDate nextDay = (sqlNextDay != null) ? sqlNextDay.toLocalDate() : null;
                        int weekOfYear = rs.getInt("WeekOfYear");
                        String month = rs.getString("Month");
                        int monthOfYear = rs.getInt("MonthOfYear");
                        int quarterOfYear = rs.getInt("QuarterOfYear");
                        int year = rs.getInt("Year");
                        boolean isWeekend = rs.getBoolean("IsWeekend");

                        // Create the DateDTO object
                        dateDTO dateDTO = new dateDTO(date, day, dayOfWeek, dayOfMonth, dayOfYear, previousDay,
                                nextDay, weekOfYear, month, monthOfYear, quarterOfYear, year, isWeekend);
                        // Add the DateDTO object to the list
                        listOfDate.add(dateDTO);
                    }
                }
            }
        } finally {
            // Close the resources in a finally block
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
        return listOfDate;
    }
}
