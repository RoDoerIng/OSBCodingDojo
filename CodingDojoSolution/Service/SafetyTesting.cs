using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service
{
    class SafetyTesting : IService
    {
        private IService service;
        private int cost;

        public SafetyTesting(IService mService)
        {
            this.service = mService;
            this.cost = 800;
        }

        public int getCost()
        {
            return this.service.getCost() + this.cost;
        }
    }
}
