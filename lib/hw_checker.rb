require 'active_support/core_ext/hash'

require_relative '../lib/base/base'
require_relative '../lib/file_scan/file_scan'
require_relative '../lib/unarchive/unarchive'
require_relative '../lib/unarchive/zip'
require_relative '../lib/test_run/test_run'
require_relative '../lib/test_run/ruby_test_run'
require_relative '../lib/test_run/python_test_run'

module HomeWorkChecker
  FILE_TYPES = {
    '.7z' => '',
    '.zip' => ''
  }
  LANGUAGE_TYPES = {
    '.rb' => TestRun::RubyTestRun,
    '.py' => TestRun::PythonTestRun
  }
end
