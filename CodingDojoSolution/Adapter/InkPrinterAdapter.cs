using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Adapter
{
    public class InkPrinterAdapter : IInkPrinter
    {
        private LaserPrinter printer2Adapt;

        public InkPrinterAdapter(LaserPrinter printer2Adapt) {
            this.printer2Adapt = printer2Adapt;
        }

        public void closeConnection()
        {
            printer2Adapt.off();
        }

        public void openConnection()
        {
            printer2Adapt.off();
            printer2Adapt.connect();
        }

        public void print(string toPrint)
        {
            printer2Adapt.isPrint(toPrint + "printed from a LaserPrinter via InkPrinterAdapter");
        }
    }
}
