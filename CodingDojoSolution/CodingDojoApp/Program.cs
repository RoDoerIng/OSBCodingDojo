using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Service;
using Adapter;


namespace CodingDojoApp
{
    class Program
    {
        static void Main(string[] args)
        {
            //ServiceClass bmwService = new MechMaintenance();

            Console.WriteLine(new MechMaintenance(new ServiceClass()).getCost());

            Portal myPortal = new Portal(new InkPrinter());

            Portal myPortalWithAdapter = new Portal(new InkPrinterAdapter(new LaserPrinter()));

            myPortal.doFoo();
            myPortalWithAdapter.doFoo();


        }


    }
}
