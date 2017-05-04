using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Service;
using Adapter;
using VehFact;


namespace CodingDojoApp
{
    class Program
    {
        static void Main(string[] args)
        {
            VehicleFactory vehicleFactory = new VehicleFactory();

            IVehicle firstVehicle;
            IVehicle secondVehicle;

            firstVehicle = vehicleFactory.create(VehicleFactory.VehicleType.Car, "SuperCar");
            secondVehicle = vehicleFactory.create(VehicleFactory.VehicleType.Motorcycle, "SuperCycle");

            firstVehicle.drive();
            secondVehicle.startEngine();
            secondVehicle.drive();
            firstVehicle.brake();
            secondVehicle.brake();
            firstVehicle.stopEngine();
            secondVehicle.stopEngine();
            
        }


    }
}
