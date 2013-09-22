module Humanize
  @@grammar = {0 => "zero", 1 => "one", 2 => "two", 3 => "three", 4 => "four", 
               5 => "five", 6 => "six", 7 => "seven", 8 => "eight", 9 => "nine",
               10 => "ten", 11 => "eleven", 12 => "twelve", 13 => "thirteen", 14 => "fourteen", 15 => "fifteen", 
               20 => "twenty", 30 => "thirty", 40 => "forty", 50 => "fifty", 80 => "eighty"}

  def self.spell number
    return @@grammar[number] unless @@grammar[number].nil?

    if (number >= 100)
      spell_hundred number
    elsif (number > 20)
      spell_dozen number
    else
      spell_teen number
    end
  end

  def self.spell_teen number
    spell(number - 10) + "teen"
  end

  def self.spell_dozen number
    result = @@grammar[round_down_to(10, number)] || (spell(number / 10) + "ty")
    result += " " + spell(number % 10) unless factor_of? 10, number
    result
  end

  def self.spell_hundred number
    result = spell(number / 100) + " " + "hundred"
    result += " and " + spell(number % 100) unless factor_of? 100, number
    result
  end

  def self.factor_of? factor, number
    number % factor == 0
  end

  def self.round_down_to factor, number
    number - (number % factor)
  end
end