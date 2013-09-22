{"untitled.rb"=>"module Humanize\n  @@grammar = {0 => \"zero\", 1 => \"one\", 2 => \"two\", 3 => \"three\", 4 => \"four\", \n               5 => \"five\", 6 => \"six\", 7 => \"seven\", 8 => \"eight\", 9 => \"nine\",\n               11 => \"eleven\", 12 => \"twelve\", 13 => \"thirteen\", 14 => \"fourteen\", 15 => \"fifteen\", \n               20 => \"twenty\", 30 => \"thirty\", 40 => \"forty\", 50 => \"fifty\", 80 => \"eighty\"}\n\n  def self.spell number\n    return @@grammar[number] unless @@grammar[number].nil?\n\n    if (number > 20)\n      spell(number / 10 * 10) + \" \" + spell(number % 10)\n    else if (number > 50)\n      spell(number / 10) + \"ty\"\n    else\n      spell(number - 10) + \"teen\"\n    end\n  end\nend", "untitled_spec.rb"=>"require './untitled'\n\ndescribe \"untitled\" do\n  \n  context \"when numbers are under 10\" do\n    it \"spells zero for 0\" do\n      Humanize::spell(0).should == \"zero\"\n    end\n\n    it \"spells one for 1\" do\n      Humanize::spell(1).should == \"one\"\n    end\n\n    it \"spells nine for 9\" do\n      Humanize::spell(9).should == \"nine\"\n    end\n  end\n\n  context \"when numbers are under sixteen\" do\n    it \"spells eleven for 11\" do\n      Humanize::spell(11).should == \"eleven\"\n    end\n\n    it \"spells twelve for 12\" do\n      Humanize::spell(12).should == \"twelve\"\n    end\n\n    it \"spells thirteen for 13\" do\n      Humanize::spell(13).should == \"thirteen\"\n    end\n\n    it \"spells fourteen for 14\" do\n      Humanize::spell(14).should == \"fourteen\"\n    end\n\n    it \"spells fifteen for 15\" do\n      Humanize::spell(15).should == \"fifteen\"\n    end\n  end\n\n  context \"when numbers from 16 through to 19\" do\n    it \"should add teen to number\" do\n      (16..19).each do |n|\n        Humanize::spell(n).should == Humanize::spell(n - 10) + \"teen\"\n      end\n    end\n  end  \n\n  context \"when round numbers under 100\" do\n    it \"should spell round numbers under 60 correctly\" do\n      (20..50).step(10) do |n|\n        case n\n          when 20\n            Humanize::spell(n).should == \"twenty\"\n          when 30\n            Humanize::spell(n).should == \"thirty\"\n          when 40\n            Humanize::spell(n).should == \"forty\"\n          when 50\n            Humanize::spell(n).should == \"fifty\"\n        end\n      end\n    end\n\n    it \"should add ty to number\" do\n      (60..90).step(10) do |n|\n        next if n == 80 \n        Humanize::spell(n).should == Humanize::spell(n/10) + \"ty\"\n      end\n    end\n\n    it \"should deal with eighty correctly\" do\n      Humanize::spell(80).should == \"eighty\"\n    end\n  end\n\n  context \"when unrounded numbers under 100\" do\n    it \"should spell dozens followed by spelled digits\" do\n      (21..99).step(11) do |n|\n        Humanize::spell(n).should == Humanize::spell(n/10*10) + \" \" + Humanize::spell(n%10)\n      end\n    end\n  end\nend", "cyber-dojo.sh"=>"# Test output can be formatted as progress or documentation\nrspec . --format progress", "instructions"=>"Spell out a number. For example\n\n      99 --> ninety nine\n     300 --> three hundred\n     310 --> three hundred and ten\n    1501 --> one thousand, five hundred and one\n   12609 --> twelve thousand, six hundred and nine\n  512607 --> five hundred and twelve thousand,\n             six hundred and seven\n43112603 --> forty three million, one hundred and\n             twelve thousand,\n             six hundred and three\n\n[Source http://rosettacode.org]", "output"=>"/var/www/cyberdojo/katas/20/191C6171/zebra/sandbox/untitled_spec.rb:1:in `require': /var/www/cyberdojo/katas/20/191C6171/zebra/sandbox/untitled.rb:18: syntax error, unexpected $end, expecting keyword_end (SyntaxError)\n\tfrom /var/www/cyberdojo/katas/20/191C6171/zebra/sandbox/untitled_spec.rb:1:in `<top (required)>'\n\tfrom /usr/local/lib/ruby/gems/1.9.1/gems/rspec-core-2.13.1/lib/rspec/core/configuration.rb:819:in `load'\n\tfrom /usr/local/lib/ruby/gems/1.9.1/gems/rspec-core-2.13.1/lib/rspec/core/configuration.rb:819:in `block in load_spec_files'\n\tfrom /usr/local/lib/ruby/gems/1.9.1/gems/rspec-core-2.13.1/lib/rspec/core/configuration.rb:819:in `each'\n\tfrom /usr/local/lib/ruby/gems/1.9.1/gems/rspec-core-2.13.1/lib/rspec/core/configuration.rb:819:in `load_spec_files'\n\tfrom /usr/local/lib/ruby/gems/1.9.1/gems/rspec-core-2.13.1/lib/rspec/core/command_line.rb:22:in `run'\n\tfrom /usr/local/lib/ruby/gems/1.9.1/gems/rspec-core-2.13.1/lib/rspec/core/runner.rb:80:in `run'\n\tfrom /usr/local/lib/ruby/gems/1.9.1/gems/rspec-core-2.13.1/lib/rspec/core/runner.rb:17:in `block in autorun'\n"}
