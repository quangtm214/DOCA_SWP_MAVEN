/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.doca_java.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.naming.NamingException;

/**
 *
 * @author Admin
 */
public class DBconnect {
     public static Connection makeConnection() throws SQLException, ClassNotFoundException, NamingException {

        
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String url = "jdbc:sqlserver://quangtmseserver.database.windows.net;databaseName=DOCA_platform"; 
        Connection con = DriverManager.getConnection(url, "quangtm", "@Quangse173475");
        return con;
    }
}
