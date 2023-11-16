/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.doca_java.DTO;

import java.io.Serializable;
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
public class saveProductDTO implements Serializable {
    private int productId;   
    private int userID;
    private int countSave;
    private String statusMatch;
    public saveProductDTO(int productId) {
        this.productId = productId;
    }

    public saveProductDTO(int productId, int countSave) {
        this.productId = productId;
        this.countSave = countSave;
    }

    public saveProductDTO(int productId, int userID, String statusMatch) {
        this.productId = productId;
        this.userID = userID;
        this.statusMatch = statusMatch;
    }
    
    
}
