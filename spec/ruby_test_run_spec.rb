require_relative '../lib/hw_checker'

module HomeWorkChecker
  module TestRunStat
    describe RubyTestRun do
      before(:all) do
        @ruby_test_run = RubyTestRun.new('./support', 'julia.tymo_creational.patterns')
        @ruby_test_run.perform
      end

      context '#count_passed_failed' do
        it 'should calculate passed tests correctly' do
          @ruby_test_run.instance_variable_get(:@passed).should == 0
        end
        it 'should calculate failed tests correctly' do
          @ruby_test_run.instance_variable_get(:@failed).should == 1
        end
      end

      context '#calc_percent_passed' do
        it 'should calculate percent passed tests correctly' do
          @ruby_test_run.send(:calc_percent_passed).should ==  0.00
        end
      end
    end
  end
end
