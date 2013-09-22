require './untitled'

describe "untitled" do
  
  context "when numbers are under 10" do
    it "spells zero for 0" do
      answer(0).should == "zero"
    end

    it "spells one for 1" do
      answer(1).should == "one"
    end
  end  

end