using System.Collections;
using System.Collections.Generic;

namespace Katas.Protozoon
{
    public class Cell
    {
        private double _agentConcentration;
        private bool _hasEye;

        public Cell(double agentConcentration, bool hasEye)
        {
            _agentConcentration = agentConcentration;
            _hasEye = hasEye;
        }

        public double AgentConcentration
        {
            get { return _agentConcentration; }
            internal set { _agentConcentration = value; }
        }

        public bool IsDiploid { get { return true; } }
        public bool HasEye { get { return _hasEye; } }
        public bool CanDevelopAnEye { get { return !_hasEye && _agentConcentration != 1.0; } }
        public bool CanDivideMitose { get { return _agentConcentration >= 4.0; } }

        public IEnumerable<Cell> Divide()
        {
            var divisionStartegy = GetDivisionStartegy();
            return divisionStartegy.Divide(this);
        }

        private DivisionStrategy GetDivisionStartegy()
        {
            return CanDivideMitose ? (DivisionStrategy) new Mitose() : new Miosis();
        }
    }
}