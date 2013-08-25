using System.Linq;
using NUnit.Framework;

namespace Katas.Statistics
{
    [TestFixture]
    public class StatisticTest
    {
        [Test]
        public void WhenInputIsEmptyShouldReturnEmptyStat()
        {
            var input = CreateEquallyFilledArray(0);

            var expected = Statistic.Empty;
            var actual = Statistic.Analyze(input);

            Assert.AreEqual(expected, actual);
        }

        [Test]
        public void WhenInputHasOneItemStatDataShouldEqualItem()
        {
            var anonymousInput = CreateEquallyFilledArray(1);

            var expectedMin = anonymousInput[0];
            var expectedMax = anonymousInput[0];
            var expectedAvg = anonymousInput[0];
            var actual = Statistic.Analyze(anonymousInput);

            Assert.AreEqual(expectedMin, actual.Minimum);
            Assert.AreEqual(expectedMax, actual.Maximum);
            Assert.AreEqual(expectedAvg, actual.Average);
        }

        [Test]
        public void WhenInputHasMultipleItemsShouldCountCorrectly()
        {
            var anonymousInput = CreateRandomlyFilledArray(4);

            var expected = anonymousInput.Length;
            var actual = Statistic.Analyze(anonymousInput);

            Assert.AreEqual(expected, actual.Count);
        }

        [Test]
        public void WhenInputHasMultipleEqualItemsStatDataShouldBeEqual()
        {
            var input = CreateEquallyFilledArray(4);

            var expectedMax = 1;
            var expectedMin = 1;
            var expectedAvg = 1;
            var actual = Statistic.Analyze(input);

            Assert.AreEqual(expectedMin, actual.Minimum);
            Assert.AreEqual(expectedMax, actual.Maximum);
            Assert.AreEqual(expectedAvg, actual.Average);
        }

        [Test]
        public void WhenSequenceHasDistinctItemsShouldFindMinimum()
        {
            var anonymousInput = CreateRandomlyFilledArray(4);

            var expected = anonymousInput.Min();
            var actual = Statistic.Analyze(anonymousInput);

            Assert.AreEqual(expected, actual.Minimum);
        }

        [Test]
        public void WhenSequenceHasDistinctItemsShouldFindMaximum()
        {
            var anonymousInput = CreateRandomlyFilledArray(4);

            var expected = anonymousInput.Max();
            var actual = Statistic.Analyze(anonymousInput);

            Assert.AreEqual(expected, actual.Maximum);
        }

        [Test]
        public void WhenSequenceHasDistinctItemsShouldFindAveragae()
        {
            var anonymousInput = CreateRandomlyFilledArray(4);

            var expected = anonymousInput.Average();
            var actual = Statistic.Analyze(anonymousInput);

            Assert.AreEqual(expected, actual.Average);
        }

        private int[] CreateEquallyFilledArray(int length)
        {
            if (length == 0)
                return new int[0];
            var result = new int[length];
            for (int i = 0; i < length; i++)
                result[i] = 1;
            return result;
        }

        private int[] CreateRandomlyFilledArray(int length)
        {
            var result = new int[length];
            var rng = new System.Random();
            for (int i = 0; i < length; i++)
                result[i] = rng.Next(10);
            return result;
        }
    }
}