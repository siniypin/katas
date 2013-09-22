require './untitled'

describe "untitled" do
  
  context "when numbers are under 10" do
    it "spells zero for 0" do
      Humanize::spell(0).should == "zero"
    end

    it "spells one for 1" do
      Humanize::spell(1).should == "one"
    end

    it "spells nine for 9" do
      Humanize::spell(9).should == "nine"
    end
  end

  context "when numbers are under sixteen" do
    it "spells eleven for 11" do
      Humanize::spell(11).should == "eleven"
    end

    it "spells twelve for 12" do
      Humanize::spell(12).should == "twelve"
    end

    it "spells thirteen for 13" do
      Humanize::spell(13).should == "thirteen"
    end

    it "spells fourteen for 14" do
      Humanize::spell(14).should == "fourteen"
    end

    it "spells fifteen for 15" do
      Humanize::spell(15).should == "fifteen"
    end
  end

  context "from 16 through to 19" do
    it "should add teen to number" do
      (16..19).each do |n|
        Humanize::spell(n).should == Humanize::spell(n - 10) + "teen"
      end
    end
  end  

  context "round numbers less then 100" do
    it "should spell round numbers under 60 correctly" do
      (20..50).step(10) do |n|
        case n
          when 20
            Humanize::spell(n).should == "twenty"
          when 30
            Humanize::spell(n).should == "thirty"
          when 40
            Humanize::spell(n).should == "forty"
          when 50
            Humanize::spell(n).should == "fifty"
        end
      end
    end

    it "should add ty to number" do
      (60..90).step(10) do |n|
        Humanize::spell(n).should == Humanize::spell(n/10) + "ty"
      end
    end
  end
end