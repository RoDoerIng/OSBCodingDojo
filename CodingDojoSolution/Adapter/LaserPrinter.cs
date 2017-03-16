using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Adapter
{
    public class LaserPrinter
    {
        public bool isPrint(string toPrint) {
            Console.WriteLine(toPrint);
            return !(toPrint.Equals(""));
        }

        public void on() { }

        public void off() { }

        public void clean() { }

        public void connect() { }


    }
}
