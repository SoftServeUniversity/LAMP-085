require 'fileutils'
require_relative './base'
require_relative './file_scan'

require_relative './unarchive/unarchive'
require_relative './unarchive/zip'
require_relative './unarchive/seven_zip'
require_relative './unarchive/standart_zip'

require_relative './test_run/test_run'
require_relative './test_run/test_base'
require_relative './test_run/ruby_test_run'
require_relative './test_run/python_test_run'


module HomeWorkChecker
  FILE_TYPES = {
    '.7z' => Unarchive::SevenZip,
    '.zip' => Unarchive::StandartZip
  }
  LANGUAGE_TYPES = {
    '.rb' => TestRun::RubyTestRun,
    '.py' => TestRun::PythonTestRun
  }
end