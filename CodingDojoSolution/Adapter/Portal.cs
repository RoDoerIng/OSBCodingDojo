using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Adapter
{
    class Portal
    {
        private IInkPrinter printer;

        public Portal(IInkPrinter printer)
        {
            this.printer = printer;
        }

        public void doFoo()
        {
            printer.openConnection();
            printer.print("printed from Portal");
            printer.closeConnection();

        }
    }
}
