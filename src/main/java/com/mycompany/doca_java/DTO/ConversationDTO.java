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
public class ConversationDTO implements Serializable {

    private int conversation_id;
    private int product_id;
    private int buyer_id;
    private int seller_id;

    public ConversationDTO(int product_id, int buyer_id, int seller_id) {
        this.product_id = product_id;
        this.buyer_id = buyer_id;
        this.seller_id = seller_id;
    }

}
