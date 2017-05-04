using System;
using System.Collections.Generic;
using System.Text;

namespace VehFact
{
    public class Motorcycle :IVehicle
    {
        public int numberOfWheels { get { return this._numberOfWheels; } }

        public string name { get { return this._name; } }

        // private fields
        private string _name;
        private int _numberOfWheels;

        // public methods
        public Motorcycle(string name)
        {
            this._name = name;
            this._numberOfWheels = 2;
        }

        public void brake()
        {
            Console.WriteLine("Motorcycle (" + this.name + "): braking on " + numberOfWheels + "wheels");
        }

        public void drive()
        {
            Console.WriteLine("Motorcycle (" + this.name + "): driving");
        }

        public void startEngine()
        {
            Console.WriteLine("Motorcycle (" + this.name + "): starting Engine");
        }

        public void stopEngine()
        {
            Console.WriteLine("Motorcycle (" + this.name + "): stopping Engine");
        }
    }
}
