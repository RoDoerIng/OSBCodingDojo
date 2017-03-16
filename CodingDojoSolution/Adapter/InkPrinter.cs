using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Adapter
{
    public class InkPrinter : IInkPrinter
    {
        public void openConnection() { }
        public void closeConnection() { }
        public void print(string toPrint) {
            Console.WriteLine(toPrint);
        }
    }
}
