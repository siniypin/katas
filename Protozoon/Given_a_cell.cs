using System.Linq;
using NUnit.Framework;
using Ploeh.AutoFixture;

namespace Katas.Protozoon
{
    [TestFixture]
    public class Given_a_cell : Fixture
    {
        [Test]
        public void should_be_diploid_initially()
        {
            //arrange 
            var sut = this.CreateAnonymous<Cell>();

            //act
            var expected = true;
            var actual = sut.IsDiploid;

            //assert
            Assert.AreEqual(expected, actual);
        }

        [Test]
        public void when_created_should_receive_signal_agent_concentration()
        {
            //arrange
            this.Inject(this.CreateAnonymous<double>());
            var anonymousConcentration = this.CreateAnonymous<double>();
            var sut = this.CreateAnonymous<Protozoon.Cell>();

            //act
            var actual = sut.AgentConcentration;

            //assert
            Assert.AreEqual(anonymousConcentration, actual);
        }

        [Test]
        public void when_created_should_develop_an_eye_if_signal_agent_concentration_greater_then_1()
        {
            //arrange
            this.Inject(0.3);
            var sut = this.CreateAnonymous<Cell>();

            //act
            var expected = this.CreateAnonymous<double>() > 1.0;
            var actual = sut.HasEye;

            //assert
            Assert.AreEqual(expected, actual);
        }

        [Test]
        public void when_signal_agent_concentration_greater_or_equal_4_should_be_able_to_divide_mitose()
        {
            //arrange
            this.Inject(4.1);
            var sut = this.CreateAnonymous<Cell>();

            //act
            var expected = this.CreateAnonymous<double>() >= 4.0;
            var actual = sut.CanDivideMitose;

            //assert
            Assert.AreEqual(expected, actual);
        }

        [Test]
        public void when_divided_mitose_should_produce_another_diploid_cell()
        {
            //arrange
            this.Inject(4.1);
            var sut = this.CreateAnonymous<Cell>();

            //act
            var expected = this.CreateAnonymous<double>() >= 4.0;
            var descendants = sut.Divide().ToArray();

            //assert
            Assert.AreEqual(2, descendants.Count());
            Assert.AreEqual(expected, descendants.First().IsDiploid);
        }

        [Test]
        public void when_divided_mitose_each_cell_should_get_a_half_concentration_of_signal_agent()
        {
            //arrange
            this.Inject(4.6);
            var sut = this.CreateAnonymous<Cell>();

            //act
            var expected = this.CreateAnonymous<double>()/2;
            var divided = sut.Divide();

            //assert
            Assert.AreEqual(expected, sut.AgentConcentration);
            Assert.AreEqual(expected, divided.First().AgentConcentration);
        }
        
        [Test]
        public void when_divided_mitose_one_of_the_descendants_should_be_the_same_cell()
        {
            //arrange
            this.Inject(4.6);
            var sut = this.CreateAnonymous<Cell>();

            //act
            var divided = sut.Divide();

            //assert
            Assert.AreSame(sut, divided.Last());
        }
        
        [Test]
        public void when_divided_mitose_should_pass_an_eye_to_one_cell_only()
        {
            //arrange
            this.Inject(4.6);
            var sut = this.CreateAnonymous<Cell>();

            //act
            var expected = sut.HasEye ? 1 : 0;
            var actual = sut.Divide().Count(x => x.HasEye);

            //assert
            Assert.AreEqual(expected, actual);
        }

        [Test]
        public void when_divided_miosis_should_produce_four_gaploid_cells()
        {
            //arrange
            this.Inject(2.2);
            var sut = this.CreateAnonymous<Cell>();

            //act
            var expected = sut.AgentConcentration < 4.0 ? true : false;
            var divided = sut.Divide().ToArray();
            var actual = divided.All(x => !x.CanDivideMitose);

            //assert
            Assert.AreEqual(4, divided.Count());
            Assert.AreEqual(expected, actual);
        }
        
        [Test]
        public void when_divided_miosis_each_cell_should_get_a_quarter_concentration()
        {
            //arrange
            this.Inject(2.2);
            var sut = this.CreateAnonymous<Cell>();

            //act
            var expected = sut.AgentConcentration / 4.0;
            var divided = sut.Divide().ToArray();

            //assert
            foreach (var cell in divided)
                Assert.AreEqual(expected, cell.AgentConcentration);
        }
    }
}