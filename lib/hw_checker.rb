require 'nokogiri'
require_relative '../lib/hw_checker/base'
require_relative '../lib/hw_checker/file_scan'
require_relative '../lib/hw_checker/unarchive'
require_relative '../lib/hw_checker/zip'
require_relative '../lib/hw_checker/test_run_stat'
require_relative '../lib/hw_checker/python_stat'
require_relative '../lib/hw_checker/python_test_run'
require_relative '../lib/hw_checker/ruby_stat'
require_relative '../lib/hw_checker/ruby_test_run'

module HomeWorkChecker
  FILE_TYPES = ['.7z', '.zip'] 
  LANGUAGE_TYPES = {
    '.rb' => [TestRunStat::RubyTestRun, TestRunStat::RubyStat],
    '.py' => [TestRunStat::PythonTestRun, TestRunStat::PythonStat]
  }
end
