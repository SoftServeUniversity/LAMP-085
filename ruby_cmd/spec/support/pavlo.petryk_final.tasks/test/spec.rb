require_relative '../run'
a = Calculator.new
a.summa

describe Calculator do
  it "Test of calculator" do
  s = Calculator.new
  s.summa.should == 2
  end
end
