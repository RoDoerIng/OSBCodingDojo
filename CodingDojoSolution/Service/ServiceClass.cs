using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service
{
    public class ServiceClass : IService
    {
        private int cost;

        public ServiceClass()
        {
            cost = 1000;
        }
        
        public int getCost()
        {
            return cost;
        }
    }


}
