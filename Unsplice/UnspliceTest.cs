using NUnit.Framework;

namespace Katas.Unsplice
{
    [TestFixture]
    public class UnspliceTest
    {
        [Test]
        public void WhenNoBackslashAndReturnShouldKeepTheStringIntact()
        {
            var anonymous = "abcdef";
            var expected = anonymous;
            var actual = Unsplice.String(anonymous);

            Assert.AreEqual(expected, actual);
        }

        [Test]
        public void WhenNoBackslashShouldKeepTheStringIntact()
        {
            var anonymous = "abc\ndef";
            var expected = anonymous;
            var actual = Unsplice.String(anonymous);

            Assert.AreEqual(expected, actual);
        }

        [Test]
        public void WhenNoReturnShouldKeepTheStringIntact()
        {
            var anonymous = "abc\\def";
            var expected = anonymous;
            var actual = Unsplice.String(anonymous);

            Assert.AreEqual(expected, actual);
        }

        [Test]
        public void WhenIncorrectOrderShouldKeepTheStringIntact()
        {
            var anonymous = "abc\n\\def";
            var expected = anonymous;
            var actual = Unsplice.String(anonymous);

            Assert.AreEqual(expected, actual);
        }

        [Test]
        public void WhenOneOccurenceShouldStripOneOut()
        {
            var anonymous = "abc\\\ndef";
            var expected = "abcdef";
            var actual = Unsplice.String(anonymous);

            Assert.AreEqual(expected, actual);
        }

        [Test]
        public void WhenTwoOccurencesShouldStripBothOut()
        {
            var anonymous = "ab\\\ncd\\\nef";
            var expected = "abcdef";
            var actual = Unsplice.String(anonymous);

            Assert.AreEqual(expected, actual);
        }
    }
}

