require File.expand_path './spec/spec_helper'
require File.expand_path './lib/hw_checker'

module HomeWorkChecker
  module ArchiveResult
    describe RubyTestRun do
      before(:all) do
        path, dirname = File.expand_path('./spec/support/'), 'alejandra.camino_rb_accounting.manager'
        @ruby_test_run = RubyTestRun.new(path, dirname)
        @ruby_test_run.perform
      end

      context '#count_passed_failed' do
        it 'should calculate passed tests correctly' do
          @ruby_test_run.instance_variable_get(:@passed).should == 2
        end
        it 'should calculate failed tests correctly' do
          @ruby_test_run.instance_variable_get(:@failed).should == 0
        end
      end

      context '#calc_percent_passed' do
        it 'should calculate percent passed tests correctly' do
          @ruby_test_run.send(:calc_percent_passed).should ==  100.0
        end
      end
    end
  end
end
