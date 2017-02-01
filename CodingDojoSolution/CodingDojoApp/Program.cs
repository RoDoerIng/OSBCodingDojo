using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Service;

namespace CodingDojoApp
{
    class Program
    {
        static void Main(string[] args)
        {
            //ServiceClass bmwService = new MechMaintenance();

            Console.WriteLine(new MechMaintenance(new ServiceClass()).getCost());

            
        }
    }
}
