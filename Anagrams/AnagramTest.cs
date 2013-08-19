
using NUnit.Framework;

[TestFixture]
public class AnagramTest
{
    [Test]
    public void WhenNullShouldBeEmptyArray()
    {
        var sut = new Anagram();

        var expected = new string[]{};
        var actual = sut.Generate(null);

        Assert.AreEqual(expected, actual);
    }
    [Test]
    public void WhenEmptyStringShouldBeEmptyArray()
    {
        var sut = new Anagram();

        var expected = new string[]{};
        var actual = sut.Generate("");

        Assert.AreEqual(expected, actual);
    }
    [Test]
    public void WhenSingleLetterShouldBeOneMemberArray()
    {
        var sut = new Anagram();

        var anonymous = "a";
        var expected = new string[]{anonymous};
        var actual = sut.Generate(anonymous);

        Assert.AreEqual(expected, actual);
    }
    [Test]
    public void WhenTwoLettersShouldBeTwoLetterArray()
    {
        var sut = new Anagram();

        var anonymous = "ab";
        var expected = new string[]{"ab","ba"};
        var actual = sut.Generate(anonymous);

        Assert.AreEqual(expected, actual);
    }
    [Test]
    public void WhenManyLettersShouldGenerateAnagrams()
    {
        var sut = new Anagram();

        var anonymous = "biro";
        var expected = new string[]{"biro","bior","brio","broi","boir","bori",
                                    "ibro","ibor","irbo","irob","iobr","iorb",
                                    "rbio","rboi","ribo","riob","robi","roib",
                                    "obir","obri","oibr","oirb","orbi","orib"};
        var actual = sut.Generate(anonymous);

        Assert.AreEqual(expected, actual);
    }
}
