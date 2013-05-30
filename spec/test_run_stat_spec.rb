require_relative '../lib/hw_checker'

module HomeWorkChecker
  describe HomeWorkChecker::TestRunStat do
    context '.detect_language' do
      before(:each) do
        @detect_test = TestRunStat.detect_language('./support/julia.tymo_creational.patterns')
      end
      it 'should contain .rb/.py tests' do
        @detect_test.should == '.rb'
      end
    end
  end
end
