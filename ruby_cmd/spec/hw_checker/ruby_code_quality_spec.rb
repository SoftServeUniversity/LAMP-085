require File.expand_path './spec/spec_helper'
require File.expand_path './lib/hw_checker'

module HomeWorkChecker
  module ArchiveResult
    describe RubyCodeQuality do
      before(:all) do
        path, dirname = File.expand_path('./spec/support/'), 'alejandra.camino_rb_accounting.manager' 
        @ruby_code_quality = RubyCodeQuality.new(path, dirname)
        @ruby_code_quality.perform
      end

      context '#count_lines_failed' do
        it 'should calculate failed lines correctly' do
          @ruby_code_quality.instance_variable_get(:@lines_failed).should == 9
        end
      end

      context '#count_lines_all' do
        it 'should calculate failed lines count correctly' do
          @ruby_code_quality.instance_variable_get(:@lines_all).should == 22
        end
      end

      context '#calc_percent_quality' do
        it 'should calculate percent correctly' do
          @ruby_code_quality.send(:calc_percent_quality).should == 59.09
        end
      end
    end
  end
end
