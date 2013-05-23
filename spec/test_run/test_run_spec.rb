require 'rubygems'
require_relative '../lib/hw_checker'

module HomeWorkChecker
  describe HomeWorkChecker::TestRun do
    context '.detect_language' do
      before(:each) do
        @detect_test = TestRun::detect_language('./support/homework-500:petrov')
      end
      it 'should contain .rb/.py tests' do
        @detect_test.should == '.rb'
      end
    end
  end
end
