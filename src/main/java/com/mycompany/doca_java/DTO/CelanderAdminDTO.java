/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.doca_java.DTO;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Time;

import java.sql.Timestamp;
import java.util.List;
import java.util.concurrent.TimeUnit;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
/**
 *
 * @author Admin
 */
public class CelanderAdminDTO implements Serializable {

    private int staff_Id;
    private int shiftId;
    private Date date;
    private String shift;
    private String status;
    private Time startTime;
    private Time endTime;
}
