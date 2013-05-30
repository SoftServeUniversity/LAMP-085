require_relative '../lib/hw_checker'

module HomeWorkChecker
  module TestRunStat
    describe RubyStat do
      before(:all) do
        @ruby_stat = RubyStat.new('./support', 'julia.tymo_creational.patterns')
        @ruby_stat.perform
      end

      context '#count_lines_failed' do
        it 'should calculate failed lines correctly' do
          @ruby_stat.instance_variable_get(:@lines_failed).should == 5
        end
      end

      context '#count_lines_all' do
        it 'should calculate failed lines count correctly' do
          @ruby_stat.instance_variable_get(:@lines_all).should == 7
        end
      end

      context '#calc_percent_quality' do
        it 'should calculate percent correctly' do
          @ruby_stat.send(:calc_percent_quality).should == 28.57
        end
      end
    end
  end
end
