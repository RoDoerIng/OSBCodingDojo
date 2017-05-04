using System;
using System.Collections.Generic;
using System.Text;

namespace VehFact
{
    public class Car : IVehicle
    {
        public int numberOfWheels { get { return this._numberOfWheels; } }

        public string name {get{ return this._name; } }

        // private fields
        private string _name;
        private int _numberOfWheels;

        // public methods
        public Car(string name)
        {
            this._name = name;
            this._numberOfWheels = 4;
        }

        public void brake()
        {
            Console.WriteLine("Car (" + this.name + "): braking on " + numberOfWheels + "wheels");
        }

        public void drive()
        {
            Console.WriteLine("Car (" + this.name + "): driving");
        }

        public void startEngine()
        {
            Console.WriteLine("Car (" + this.name + "): starting Engine");
        }

        public void stopEngine()
        {
            Console.WriteLine("Car (" + this.name + "): stopping Engine");
        }
    }
}
