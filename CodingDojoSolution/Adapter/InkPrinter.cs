using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Adapter
{
    class InkPrinter : IInkPrinter
    {
        public void openConnection() { }
        public void closeConnection() { }
        public void print(string toPrint) { }
    }
}
