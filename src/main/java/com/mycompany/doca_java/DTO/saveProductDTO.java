/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.doca_java.DTO;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.concurrent.TimeUnit;
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
    private Timestamp timeSave;

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

    public saveProductDTO(int productId, int userID, String statusMatch, Timestamp timeSave) {
        this.productId = productId;
        this.userID = userID;
        this.statusMatch = statusMatch;
        this.timeSave = timeSave;
    }

    
    public String formatTimeDifference() {
        Timestamp currentTime = new Timestamp(System.currentTimeMillis());
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(currentTime);
        calendar.add(Calendar.HOUR_OF_DAY, -7);
        Timestamp modifiedTime = new Timestamp(calendar.getTimeInMillis());
        long timeDifferenceMillis =  modifiedTime.getTime()  - timeSave.getTime();

        long days = TimeUnit.MILLISECONDS.toDays(timeDifferenceMillis);
        long hours = TimeUnit.MILLISECONDS.toHours(timeDifferenceMillis) % 24;
        long minutes = TimeUnit.MILLISECONDS.toMinutes(timeDifferenceMillis) % 60;

        String formattedTimeDifference;
        if (days > 0) {
            formattedTimeDifference = days + " ngày trước";
        } else if (hours > 0) {
            formattedTimeDifference = hours + " giờ trước";
        } else {
            formattedTimeDifference = minutes + " phút trước";
        }

        return formattedTimeDifference;
    }

}
