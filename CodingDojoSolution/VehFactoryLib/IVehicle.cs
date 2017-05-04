using System;

namespace VehFact
{
    public interface IVehicle
    {
        int numberOfWheels { get; }
        string name { get; }

        void startEngine();
        void stopEngine();

        void drive();
        void brake();

    }
}
