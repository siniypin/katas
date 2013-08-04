using System;
using System.Collections;
using System.Linq;

namespace CidrRangeKata
{
    public class CidrRange
    {
        //auto-props for the sake of simplicity
        public byte Suffix { get; private set; }
        public byte[] Prefix { get; private set; }

        public CidrRange(string range)
        {
            //assert not null
            var parts = range.Split('/');
            //assert count 2
            var prefixParts = parts[0].Split('.').Reverse();
            //assert count 4
            Prefix = prefixParts.Select(byte.Parse).ToArray();
            Suffix = byte.Parse(parts[1]);
        }

        public RangeIntersectionResult CompareTo(CidrRange other)
        {
            if (Equals(other))
                return RangeIntersectionResult.Equals;

            if (PrefixesEquals(other) && Suffix > other.Suffix)
                return RangeIntersectionResult.Subset;
            if (PrefixesEquals(other) && Suffix < other.Suffix)
                return RangeIntersectionResult.Superset;

            return RangeIntersectionResult.Disjoint;
        }

        public override int GetHashCode()
        {
            unchecked
            {
                return (Suffix.GetHashCode() * 397) ^ (Prefix != null ? Prefix.GetHashCode() : 0);
            }
        }

        public override bool Equals(object obj)
        {
            if (ReferenceEquals(null, obj)) return false;
            if (ReferenceEquals(this, obj)) return true;
            if (obj.GetType() != this.GetType()) return false;
            return Equals((CidrRange)obj);
        }

        public override string ToString()
        {
            return string.Format("Prefix: {0}, Suffix: {1}", BitConverter.ToUInt32(Prefix, 0), Suffix);
        }

        protected bool Equals(CidrRange other)
        {
            return Suffix == other.Suffix && PrefixesEquals(other);
        }

        private bool PrefixesEquals(CidrRange other)
        {
            var leftMask = new BitArray(Prefix);
            var leftSuffix = new BitArray(32, false);
            for (int i = 31; i >= 32 - Suffix; i--)
            {
                leftSuffix[i] = true;
            }
            leftMask = leftSuffix.And(leftMask);

            var rightMask = new BitArray(other.Prefix);
            var rightSuffix = new BitArray(32, false);
            for (int i = 31; i >= 32 - other.Suffix; i--)
            {
                rightSuffix[i] = true;
            }
            rightMask = rightSuffix.And(rightMask);

            var result = rightMask.Xor(leftMask);
            return result.Cast<bool>().ToArray().Skip(32 - Math.Min(Suffix, other.Suffix)).All(x => !x);
        }
    }
}