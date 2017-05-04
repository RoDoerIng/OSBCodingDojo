using System;
using System.Collections.Generic;
using System.Text;

namespace VehFact
{
    public class VehicleFactory
    {
        public enum VehicleType
        {
            Car,
            Motorcycle,
            Truck
        }

        public VehicleFactory() { }

        public IVehicle create(VehicleType vehicleType, String name)
        {
            switch (vehicleType)
            {
                case VehicleType.Car:
                    return new Car(name);
                case VehicleType.Motorcycle:
                    return new Motorcycle(name);
                default:
                    return new Car(name);
            }
        }
    }
}
