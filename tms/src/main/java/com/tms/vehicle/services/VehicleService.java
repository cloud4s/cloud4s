package com.tms.vehicle.services;

import com.tms.vehicle.dao.IVehicleDAO;
import com.tms.vehicle.dao.VehcleDAO;
import com.tms.vehicle.model.Vehicle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by hp on 8/7/2017.
 */

@Service
public class VehicleService implements IVehicleService {

    @Autowired
    private IVehicleDAO vehicleDAO;

    @Override
    public List<Vehicle> getAllVehicles() {
        return vehicleDAO.getAllVehicles();
    }

    @Override
    public Vehicle getVehicleByNum(String vehicleNum) {
        return vehicleDAO.getVehivleByNumber(vehicleNum);
    }
}
