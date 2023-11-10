/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.doca_java.DTO;

import java.io.Serializable;
import java.sql.Timestamp;
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

/**
 *
 * @author Admin
 */
public class NotificationDTO implements Serializable {

    private int notificationId;
    private int userId;
    private String notification_value;
    private Timestamp timeNotification;

    public NotificationDTO(int userId, String notification_value, Timestamp timeNotification) {
        this.userId = userId;
        this.notification_value = notification_value;
        this.timeNotification = timeNotification;
    }

}
