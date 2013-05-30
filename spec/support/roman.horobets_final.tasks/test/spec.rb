require_relative '../run.rb'
a = Calculator.new
a.summa

describe Calculator do
  it "Test of calculator" do
  s = Calculator.new
  s.summa.should == 21
  end

  it "Test of calculator" do
  s = Calculator.new
  s.summa.should == -3
  end

  it "Test of calculator" do
  s = Calculator.new
  s.summa.should == 2
  end
end
