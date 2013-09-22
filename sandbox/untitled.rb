module Humanize
  @@grammar = {0 => "zero", 1 => "one", 2 => "two", 3 => "three", 4 => "four", 
               5 => "five", 6 => "six", 7 => "seven", 8 => "eight", 9 => "nine",
               11 => "eleven", 12 => "twelve", 13 => "thirteen", 14 => "fourteen", 15 => "fifteen", 
               20 => "twenty", 30 => "thirty", 40 => "forty", 50 => "fifty"}

  def self.spell number
    return @@grammar[number] unless @@grammar[number].nil?

    if (number > 50)
      spell(number / 10) + "ty"

    if (number > 15)
      spell(number - 10) + "teen"
    end
  end

end