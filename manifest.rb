{"untitled.rb"=>"module Humanize\n  @@grammar = {0 => \"zero\", 1 => \"one\", 2 => \"two\", 3 => \"three\", 4 => \"four\", \n               5 => \"five\", 6 => \"six\", 7 => \"seven\", 8 => \"eight\", 9 => \"nine\",\n               10 => \"ten\", 11 => \"eleven\", 12 => \"twelve\", 13 => \"thirteen\", 14 => \"fourteen\", 15 => \"fifteen\", \n               20 => \"twenty\", 30 => \"thirty\", 40 => \"forty\", 50 => \"fifty\", 80 => \"eighty\"}\n\n  def self.spell number\n    return @@grammar[number] unless @@grammar[number].nil?\n\n    if (number >= 1000)\n      spell_thousand number\n    elsif (number >= 100)\n      spell_hundred number\n    elsif (number > 20)\n      spell_dozen number\n    else\n      spell_teen number\n    end\n  end\n\n  def self.spell_teen number\n    spell(number - 10) + \"teen\"\n  end\n\n  def self.spell_dozen number\n    result = @@grammar[round_down_to(10, number)] || (spell(number / 10) + \"ty\")\n    result += \" \" + spell(number % 10) unless factor_of? 10, number\n    result\n  end\n\n  def self.spell_hundred number\n    result = spell(number / 100) + \" hundred\"\n    result += \" and \" + spell(number % 100) unless factor_of? 100, number\n    result\n  end\n\n  def self.spell_thousand number\n    result = spell(number / 1000) + \" thousand\"\n    result += \", \" + spell(number % 1000) unless factor_of? 1000, number\n    result \n  end\n\n  def self.factor_of? factor, number\n    number % factor == 0\n  end\n\n  def self.round_down_to factor, number\n    number - (number % factor)\n  end\nend", "untitled_spec.rb"=>"require './untitled'\n\ndescribe \"untitled\" do\n  \n  context \"when numbers are under 10\" do\n    it \"spells zero for 0\" do\n      Humanize::spell(0).should == \"zero\"\n    end\n\n    it \"spells one for 1\" do\n      Humanize::spell(1).should == \"one\"\n    end\n\n    it \"spells nine for 9\" do\n      Humanize::spell(9).should == \"nine\"\n    end\n  end\n\n  context \"when numbers are under sixteen\" do\n    it \"spells ten for 10\" do\n      Humanize::spell(10).should == \"ten\"\n    end\n\n    it \"spells eleven for 11\" do\n      Humanize::spell(11).should == \"eleven\"\n    end\n\n    it \"spells twelve for 12\" do\n      Humanize::spell(12).should == \"twelve\"\n    end\n\n    it \"spells thirteen for 13\" do\n      Humanize::spell(13).should == \"thirteen\"\n    end\n\n    it \"spells fourteen for 14\" do\n      Humanize::spell(14).should == \"fourteen\"\n    end\n\n    it \"spells fifteen for 15\" do\n      Humanize::spell(15).should == \"fifteen\"\n    end\n  end\n\n  context \"when numbers from 16 through to 19\" do\n    it \"should add teen to number\" do\n      (16..19).each do |n|\n        Humanize::spell(n).should == Humanize::spell(n - 10) + \"teen\"\n      end\n    end\n  end  \n\n  context \"when round numbers under 100\" do\n    it \"should spell round numbers under 60 correctly\" do\n      (20..50).step(10) do |n|\n        case n\n          when 20\n            Humanize::spell(n).should == \"twenty\"\n          when 30\n            Humanize::spell(n).should == \"thirty\"\n          when 40\n            Humanize::spell(n).should == \"forty\"\n          when 50\n            Humanize::spell(n).should == \"fifty\"\n        end\n      end\n    end\n\n    it \"should add ty to number\" do\n      (60..90).step(10) do |n|\n        next if n == 80 \n        Humanize::spell(n).should == Humanize::spell(n/10) + \"ty\"\n      end\n    end\n\n    it \"should deal with eighty correctly\" do\n      Humanize::spell(80).should == \"eighty\"\n    end\n  end\n\n  context \"when unrounded numbers under 100\" do\n    it \"should spell dozens followed by spelled digits\" do\n      (21..99).step(11) do |n|\n        Humanize::spell(n).should == Humanize::spell(n/10*10) + \" \" + Humanize::spell(n%10)\n      end\n    end\n  end\n\n  context \"when rounded hundreds\" do\n    it \"should spell one hundred for 100\" do\n      Humanize::spell(100).should == \"one hundred\"\n    end\n\n    it \"should not pluralize hundreds for numbers higher then 100\" do\n      (200..900).step(100) do |n|\n        Humanize::spell(n).should == Humanize::spell(n / 100) + \" hundred\"\n      end\n    end\n  end\n\n  context \"when unrounded numbers under thousand\" do\n    it \"should spell hundreds followed by spelled dozens followed by spelled digits\" do\n      (101..999).step(111) do |n|\n        Humanize::spell(n).should == Humanize::spell(n/100*100) + \" and \" + Humanize::spell(n%100)\n      end\n    end\n  end\n\n  context \"when numbers above thousand\" do\n    it \"should spell one thousand for 1000\" do\n      Humanize::spell(1000).should == \"one thousand\"\n    end\n\n    it \"should spell one thousand, five hundred and one for 1501\" do\n      Humanize::spell(1501).should == \"one thousand, five hundred and one\"\n    end\n\n    it \"should spell twelve thousand, six hundred and nine for 12609\" do\n      Humanize::spell(12609).should == \"twelve thousand, six hundred and nine\"\n    end\n\n    it \"should spell five hundred and twelve thousand, six hundred and seven for 512607\" do\n      Humanize::spell(512607).should == \"five hundred and twelve thousand, six hundred and seven\"\n    end\n  end\nend", "cyber-dojo.sh"=>"# Test output can be formatted as progress or documentation\nrspec . --format progress", "instructions"=>"Spell out a number. For example\n\n      99 --> ninety nine\n     300 --> three hundred\n     310 --> three hundred and ten\n    1501 --> one thousand, five hundred and one\n   12609 --> twelve thousand, six hundred and nine\n  512607 --> five hundred and twelve thousand,\n             six hundred and seven\n43112603 --> forty three million, one hundred and\n             twelve thousand,\n             six hundred and three\n\n[Source http://rosettacode.org]", "output"=>".....................\n\nFinished in 0.00344 seconds\n21 examples, 0 failures\n"}
