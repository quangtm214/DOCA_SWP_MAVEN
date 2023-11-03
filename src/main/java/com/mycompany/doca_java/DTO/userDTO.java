/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.doca_java.DTO;

import java.io.Serializable;
import javax.print.DocFlavor;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 *
 * @author Admin
 */
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class userDTO implements Serializable {
    private int user_ID;
    private String userName;
    private String password;
    private String gender;
    private String email;
    private String mobileNum;
    private boolean status;
    private boolean roleID;
    private String avatar;

    public userDTO(String userName, String password, String gender, String email, String mobileNum, boolean status, boolean roleID, String avatar) {
        this.userName = userName;
        this.password = password;
        this.gender = gender;
        this.email = email;
        this.mobileNum = mobileNum;
        this.status = status;
        this.roleID = roleID;
        this.avatar = avatar;
    }
    
    
    
}
