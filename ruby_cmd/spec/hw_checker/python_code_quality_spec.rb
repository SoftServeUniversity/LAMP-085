require File.expand_path './spec/spec_helper'
require File.expand_path './lib/hw_checker'

module HomeWorkChecker
  module ArchiveResult
    describe PythonCodeQuality do
      before(:all) do
        @path, @dirname = File.expand_path('./spec/support/'), '/daniel.tonini_py_sales.representative'
        @python_code_quality = PythonCodeQuality.new(@path, @dirname)
        @python_code_quality.perform
      end
 
      context '#calc_percent_quality' do
        it 'should calculate percent correctly' do
          filename = @path+@dirname+"/tests/statistic/TestAnalyser.py.tmp"
          @python_code_quality.send(:calc_percent_quality, filename).should == 46.2
        end
      end
    end
  end
end
