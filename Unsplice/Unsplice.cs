
namespace Katas.Unsplice
{
    public class Unsplice
    {
        private const int SequenceLength = 2;
        private const string Sequence = "\\\n";

        public static string String(string input)
        {
            var result = input;
            for (int index = result.IndexOf(Sequence); index != -1; index = result.IndexOf(Sequence))
                result = result.Remove(index, SequenceLength);
            return result;
        }
    }
}
