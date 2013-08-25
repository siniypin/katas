using System;
using System.Collections.Generic;
using System.Linq;

namespace Katas.Anagrams
{
    public class Anagram
    {
        public string[] Generate(string input)
        {
            if (string.IsNullOrEmpty(input))
                return new string[]{};
        
            var result = new List<string>();

            if (IsOneLetterString(input))
            {
                result.Add(input);
            }
            else if (IsTwoLettersString(input))
            {
                result.Add(input);
                result.Add(new String(input.Reverse().ToArray()));
            }
            else
            {
                for (int i = 0; i < input.Length; i++)
                {
                    var currentChar = input[i];
                    var reminder = new String(input.Except(new[] {currentChar}).ToArray());
                    var subresults = Generate(reminder);
                    foreach (string s in subresults)
                        result.Add(currentChar + s);
                }
            }
        
            return result.ToArray();
        }

        public bool IsOneLetterString(string input)
        {
            return input.Length == 1;
        }

        public bool IsTwoLettersString(string input)
        {
            return input.Length == 2;
        }
    }
}