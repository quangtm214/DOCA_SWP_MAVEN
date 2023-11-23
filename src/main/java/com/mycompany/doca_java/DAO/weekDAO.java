/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.doca_java.DAO;

import com.mycompany.doca_java.DTO.weekDTO;
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
public class weekDAO {

    private List<weekDTO> ListOfWeek;

    public List<weekDTO> getListOfWeek() {
        return ListOfWeek;
    }

    public void getAllTheWeek() throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBconnect.makeConnection();
            if (con != null) {
                // Create the new SQL query
                String sql = "SELECT "
                        + "MIN(CASE WHEN DayOfWeek = 2 THEN Date END) AS StartOfWeek, "
                        + "DATEADD(DAY, 1, MAX(CASE WHEN DayOfWeek = 7 THEN Date END)) AS EndOfWeek "
                        + "FROM tblCalendar "
                        + "GROUP BY Year, WeekOfYear "
                        + "ORDER BY StartOfWeek";

                // Create the statement object
                stm = con.prepareStatement(sql);

                // Execute the query
                rs = stm.executeQuery();

                // Process the result
                while (rs.next()) {
                    java.sql.Date sqlStartDate = rs.getDate("StartOfWeek");
                    java.sql.Date sqlEndDate = rs.getDate("EndOfWeek");
                    if (sqlStartDate != null && sqlEndDate != null) {
                        LocalDate startDate = sqlStartDate.toLocalDate();
                        LocalDate endDate = sqlEndDate.toLocalDate();

                        // Set properties of weekDTO object
                        weekDTO week = new weekDTO(startDate, endDate);

                        // Add data to the list
                        if (this.ListOfWeek == null) {
                            this.ListOfWeek = new ArrayList<>();
                        }
                        ListOfWeek.add(week);
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
    }
}
