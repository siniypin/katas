require './untitled'

describe "untitled" do
  shared_examples_for "number humanizer" do |number, words|
    it "should spell #{words} for #{number}" do
      Humanize::spell(number).should == words
    end
  end

  context "when numbers are under 10" do
    it_behaves_like "number humanizer", 0, "zero"
    it_behaves_like "number humanizer", 1, "one"
    it_behaves_like "number humanizer", 9, "nine"
  end

  context "when numbers are under sixteen" do
    it_behaves_like "number humanizer", 10, "ten"
    it_behaves_like "number humanizer", 11, "eleven"
    it_behaves_like "number humanizer", 12, "twelve"
    it_behaves_like "number humanizer", 13, "thirteen"
    it_behaves_like "number humanizer", 14, "fourteen"
    it_behaves_like "number humanizer", 15, "fifteen"
  end

  context "when numbers from 16 through to 19" do
    it "should add teen to number" do
      (16..19).each do |n|
        Humanize::spell(n).should == Humanize::spell(n - 10) + "teen"
      end
    end
  end  

  context "when round numbers under 100" do
    it_behaves_like "number humanizer", 20, "twenty"
    it_behaves_like "number humanizer", 30, "thirty"
    it_behaves_like "number humanizer", 40, "forty"
    it_behaves_like "number humanizer", 50, "fifty"
    it_behaves_like "number humanizer", 80, "eighty"

    it "should add ty to number" do
      (60..90).step(10) do |n|
        next if n == 80 
        Humanize::spell(n).should == Humanize::spell(n/10) + "ty"
      end
    end
  end

  context "when unrounded numbers under 100" do
    it "should spell dozens followed by spelled digits" do
      (21..99).step(11) do |n|
        Humanize::spell(n).should == Humanize::spell(n/10*10) + " " + Humanize::spell(n%10)
      end
    end
  end

  context "when rounded hundreds" do
    it_behaves_like "number humanizer", 100, "one hundred"
    it_behaves_like "number humanizer", 200, "two hundred"
    it_behaves_like "number humanizer", 900, "nine hundred"
  end

  context "when unrounded numbers under thousand" do
    it "should spell hundreds followed by spelled dozens followed by spelled digits" do
      (101..999).step(111) do |n|
        Humanize::spell(n).should == Humanize::spell(n/100*100) + " and " + Humanize::spell(n%100)
      end
    end
  end

  context "when numbers above thousand" do
    it_behaves_like "number humanizer", 1000, "one thousand"
    it_behaves_like "number humanizer", 1501, "one thousand, five hundred and one"
    it_behaves_like "number humanizer", 12609, "twelve thousand, six hundred and nine"
    it_behaves_like "number humanizer", 512607, "five hundred and twelve thousand, six hundred and seven"
  end
end