{"untitled.rb"=>"module Humanize\n  @@grammar = {0 => \"zero\", 1 => \"one\", 2 => \"two\", 3 => \"three\", 4 => \"four\", \n               5 => \"five\", 6 => \"six\", 7 => \"seven\", 8 => \"eight\", 9 => \"nine\",\n               11 => \"eleven\", 12 => \"twelve\", 13 => \"thirteen\", 14 => \"fourteen\", 15 => \"fifteen\"}\n\n  def self.spell number\n    if (number > 15)\n      spell(number - 10) + \"teen\"\n    else\n      @@grammar[number]\n    end\n  end\n\nend\n", "untitled_spec.rb"=>"require './untitled'\n\ndescribe \"untitled\" do\n  \n  context \"when numbers are under 10\" do\n    it \"spells zero for 0\" do\n      Humanize::spell(0).should == \"zero\"\n    end\n\n    it \"spells one for 1\" do\n      Humanize::spell(1).should == \"one\"\n    end\n\n    it \"spells nine for 9\" do\n      Humanize::spell(9).should == \"nine\"\n    end\n  end\n\n  context \"when numbers are under sixteen\" do\n    it \"spells eleven for 11\" do\n      Humanize::spell(11).should == \"eleven\"\n    end\n\n    it \"spells twelve for 12\" do\n      Humanize::spell(12).should == \"twelve\"\n    end\n\n    it \"spells thirteen for 13\" do\n      Humanize::spell(13).should == \"thirteen\"\n    end\n\n    it \"spells fourteen for 14\" do\n      Humanize::spell(14).should == \"fourteen\"\n    end\n\n    it \"spells fifteen for 15\" do\n      Humanize::spell(15).should == \"fifteen\"\n    end\n  end\n\n  context \"from 16 through to 19\" do\n    it \"should add teen to number\" do\n      (16..19).each do |n|\n        Humanize::spell(n).should == Humanize::spell(n - 10) + \"teen\"\n      end\n    end\n  end  \n\nend", "cyber-dojo.sh"=>"# Test output can be formatted as progress or documentation\nrspec . --format progress", "instructions"=>"Spell out a number. For example\n\n      99 --> ninety nine\n     300 --> three hundred\n     310 --> three hundred and ten\n    1501 --> one thousand, five hundred and one\n   12609 --> twelve thousand, six hundred and nine\n  512607 --> five hundred and twelve thousand,\n             six hundred and seven\n43112603 --> forty three million, one hundred and\n             twelve thousand,\n             six hundred and three\n\n[Source http://rosettacode.org]", "output"=>".........\n\nFinished in 0.00143 seconds\n9 examples, 0 failures\n"}
