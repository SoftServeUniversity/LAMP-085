require 'rubygems'
require_relative '../lib/DirectoryManager'
require_relative '../lib/exec.rb'

describe DirectoryManager do
	describe '#to_s' do
		before(:each) do
			@object = DirectoryManager.new
		end
		it 'return empty' do
			@object.to_s.should eq "[]\n[]"
		end
	end
end

a = Calculator.new
 
a.summa

describe Calculator do
    it "Test of calculator" do
    s = Calculator.new
    s.summa.should == 6006
end
end