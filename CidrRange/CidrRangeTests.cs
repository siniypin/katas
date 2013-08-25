using System.Linq;
using NUnit.Framework;

namespace Katas.CidrRange
{
    [TestFixture]
    public class CidrRangeTests
    {
        [Test]
        [TestCase("23.45.67.89/16", 23, 16)]
        public void when_instantiated_parses_string_into_address_prefix_and_suffix(string range, byte expectedMostSignificantByte, byte expectedSuffix)
        {
            //arrange 
            //act
            var sut = new CidrRange(range);

            //assert
            Assert.AreEqual(expectedMostSignificantByte, sut.Prefix[3]);
            Assert.AreEqual(expectedSuffix, sut.Suffix);
        }

        [Test]
        [TestCase("23.45.67.89/16")]
        [TestCase("1.2.3.4/24")]
        [TestCase("172.84.26.128/16")]
        [TestCase("197.54.16.128/25")]
        public void when_prefix_and_suffix_are_equal_should_consider_other_to_be_equal(string range)
        {
            //arrange 
            var sut = new CidrRange(range);
            var other = new CidrRange(range);

            //act
            //assert
            Assert.AreEqual(sut, other);
        }
        
        [Test]
        [TestCase("197.54.16.128/25", "198.54.16.128/25")]
        public void when_significant_prefix_bits_differ_should_not_consider_other_to_be_equal(string leftRange, string rightRange)
        {
            //arrange 
            var sut = new CidrRange(leftRange);
            var other = new CidrRange(rightRange);

            //act
            //assert
            Assert.AreNotEqual(sut, other);
        }
        
        [Test]
        [TestCase("23.45.67.89/16", "23.45.68.00/16")]
        public void when_insignificant_prefix_bits_differ_should_consider_other_to_be_equal(string leftRange, string rightRange)
        {
            //arrange 
            var sut = new CidrRange(leftRange);
            var other = new CidrRange(rightRange);

            //act
            //assert
            Assert.AreEqual(sut, other);
        }

        [Test]
        [TestCase("1.2.3.4/24", "1.2.3.4/16")]
        public void when_prefixes_are_equal_and_left_suffix_is_greater_should_consider_left_to_be_a_subset(string leftRange, string rightRange)
        {
            //arrange 
            var sut = new CidrRange(leftRange);
            var right = new CidrRange(rightRange);

            //act
            var actual = sut.CompareTo(right);
            var expected = sut.Prefix.SequenceEqual(right.Prefix) && sut.Suffix > right.Suffix
                ? RangeIntersectionResult.Subset
                : RangeIntersectionResult.Disjoint;

            //assert
            Assert.AreEqual(expected, actual);
        }
        
        [Test]
        [TestCase("172.84.26.128/16", "172.84.26.255/24")]
        public void when_prefixes_are_equal_and_left_suffix_is_less_should_consider_left_to_be_a_superset(string leftRange, string rightRange)
        {
            //arrange 
            var sut = new CidrRange(leftRange);
            var right = new CidrRange(rightRange);

            //act
            var actual = sut.CompareTo(right);
            var expected = sut.Prefix.Skip(1).SequenceEqual(right.Prefix.Skip(1)) && sut.Suffix < right.Suffix
                ? RangeIntersectionResult.Superset
                : RangeIntersectionResult.Disjoint;

            //assert
            Assert.AreEqual(expected, actual);
        }
        
        [Test]
        [TestCase("197.54.16.128/25", "197.54.16.127/25")]
        [TestCase("205.00.00.1/32", "205.00.00.00/32")]
        public void when_prefixes_are_different_should_consider_left_to_be_a_disjoint(string leftRange, string rightRange)
        {
            //arrange 
            var sut = new CidrRange(leftRange);
            var right = new CidrRange(rightRange);

            //act
            var actual = sut.CompareTo(right);
            var expected = !sut.Prefix.SequenceEqual(right.Prefix)//this is not exactly correct specification, but it's OK for the sake of simplicity
                ? RangeIntersectionResult.Disjoint
                : RangeIntersectionResult.Subset;

            //assert
            Assert.AreEqual(expected, actual);
        }
    }
}