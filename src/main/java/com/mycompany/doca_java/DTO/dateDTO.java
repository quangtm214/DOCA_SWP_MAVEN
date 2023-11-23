/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.doca_java.DTO;

import java.time.LocalDate;
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
public class dateDTO {
    private LocalDate date;
    private String day;
    private int dayOfWeek;
    private int dayOfMonth;
    private int dayOfYear;
    private LocalDate previousDay;
    private LocalDate nextDay;
    private int weekOfYear;
    private String month;
    private int monthOfYear;
    private int quarterOfYear;
    private int year;
    private boolean isWeekend;
    
}
