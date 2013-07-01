require 'nokogiri'
require 'yaml'

require File.expand_path './lib/hw_checker/base'
require File.expand_path './lib/hw_checker/file_scan'
require File.expand_path './lib/hw_checker/string'
require File.expand_path './lib/hw_checker/unarchive'
require File.expand_path './lib/hw_checker/unarchive/zip'
require File.expand_path './lib/hw_checker/exceptions/directory_exist_error'
require File.expand_path './lib/hw_checker/exceptions/directory_format_error'
require File.expand_path './lib/hw_checker/archive_result'
require File.expand_path './lib/hw_checker/archive_result/abstract_code_quality'
require File.expand_path './lib/hw_checker/archive_result/abstract_test_run'
require File.expand_path './lib/hw_checker/archive_result/python_code_quality'
require File.expand_path './lib/hw_checker/archive_result/python_test_run'
require File.expand_path './lib/hw_checker/archive_result/ruby_code_quality'
require File.expand_path './lib/hw_checker/archive_result/ruby_test_run'


module HomeWorkChecker
  def self.configurate
    fname = File.expand_path('./config/default.yml')
    hash_conf = YAML.load_file fname
    archive_types, language_types, module_types = hash_conf['archives'].split(' '), {}, {}
    hash_conf['languages'].each do |key, value|
      language_types[key] = value
      module_types[value] = hash_conf['modules'][value]
    end
    [archive_types, language_types, module_types]
  end

  ARCHIVE_TYPES, LANGUAGE_TYPES, MODULE_TYPES = self.configurate
end
