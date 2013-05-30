require_relative '../run.rb'

describe Calculator do
  it {subject.total.should == 21}
end
