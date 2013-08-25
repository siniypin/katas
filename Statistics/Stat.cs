public class Statistic
{
    private static readonly Statistic _empty = new Statistic(0,0,0,0);

    public int Minimum { get; private set; }
    public int Maximum { get; private set; }
    public int Count { get; private set; }
    public double Average { get; private set; }

    private Statistic(int min, int max, int count, double avg)
    {
        Minimum = min;
        Maximum = max;
        Count = count;
        Average = avg;
    }

    public static Statistic Empty
    {
        get { return _empty; }
    }

    public static Statistic Analyze(int[] input)
    {
        if (input.Length == 0)
            return Empty;
        
        int min = input[0];
        int max = input[0];
        int sum = input[0];
        for (int i = 1; i < input.Length; i++)
        {
            sum += input[i];
            if (input[i] < min)
                min = input[i];
            if (input[i] > max)
                max = input[i];
        }
        return new Statistic(min, max, input.Length, (double)sum/input.Length);
    }
}