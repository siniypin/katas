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

end