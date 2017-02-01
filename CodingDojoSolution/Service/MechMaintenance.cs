using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service
{
    public class MechMaintenance : IService
    {
        private IService service;
        private int cost;

        public MechMaintenance(IService mService)
        {
            this.service = mService;
            this.cost = 1400;
        }

        public int getCost()
        {
            return this.service.getCost() + this.cost;
        }
    }
}
