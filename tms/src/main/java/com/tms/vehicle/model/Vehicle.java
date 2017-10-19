package com.tms.vehicle.model;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by hp on 8/7/2017.
 */

@Entity
@Table(name="t_vehicle")
public class Vehicle implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    @Column(name="vehicle_id")
    private int vehicleId;
    @Column(name="vehicle_no")
    private String vehicleNo;
    @Column(name="vehicle_type")
    private String vehicleType;

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public void setVehicleNo(String vehicleNo) {
        this.vehicleNo = vehicleNo;
    }

    public void setVehicleType(String vehicleType) {
        this.vehicleType = vehicleType;
    }

    public int getVehicleId() {
        return vehicleId;
    }

    public String getVehicleNo() {
        return vehicleNo;
    }

    public String getVehicleType() {
        return vehicleType;
    }
}
