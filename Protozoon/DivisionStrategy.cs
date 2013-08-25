using System.Collections.Generic;

namespace Katas.Protozoon
{
    public abstract class DivisionStrategy
    {
        public abstract IEnumerable<Cell> Divide(Cell origin);
    }

    public class Mitose : DivisionStrategy
    {
        public override IEnumerable<Cell> Divide(Cell origin)
        {
            origin.AgentConcentration /= 2;
            return new [] {new Cell(origin.AgentConcentration, false), origin};
        }
    }

    public class Miosis : DivisionStrategy
    {
        public override IEnumerable<Cell> Divide(Cell origin)
        {
            return new[]
            {
                new Cell(origin.AgentConcentration/4, false), new Cell(origin.AgentConcentration/4, false),
                new Cell(origin.AgentConcentration/4, false), new Cell(origin.AgentConcentration/4, false),
            };
        }
    }
}