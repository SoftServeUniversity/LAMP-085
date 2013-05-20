require 'rubygems'
require_relative '../lib/hw_checker'

describe HomeWorkChecker::TestRun::TestBase do
  before(:each) do
    @test_base = HomeWorkChecker::TestRun::TestBase.new('../source/homework-500:petrov')
  end
  it 'should contain .rb/.py tests' do
    @test_base.detect_language.should == '.rb'
  end
end
