using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Adapter
{
    public interface IInkPrinter
    {
        void openConnection();
        void closeConnection();
        void print(string toPrint);
    }
}
