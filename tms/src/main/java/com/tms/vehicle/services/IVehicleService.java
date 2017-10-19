package com.tms.vehicle.services;

import com.tms.vehicle.model.Vehicle;

import java.util.List;

/**
 * Created by hp on 8/7/2017.
 */
public interface IVehicleService {

    List<Vehicle> getAllVehicles();

    Vehicle getVehicleByNum(String vehicleNum);
}
