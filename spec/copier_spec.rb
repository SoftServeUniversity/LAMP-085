require 'rubygems'
require 'unarchive'

require_relative '../lib/file_manager'

describe FileManager::Copier do
  it '#tmp_to_homework_method_test' do
  	FileUtils::mkdir_p("#{Unarchive::TMP_PATH}/test")
  	`unzip ../bin/my_folder/test:test -d ../bin/temp/test`
  	item = FileManager::Copier.new("test","test")
    item.tmp_to_homework.should == "ruby"
  end
end

describe FileManager::Copier do
  it '#check test folder in homework' do
  	Dir::entries("../bin/homework/ruby/test").include?("test").should == true
  end
  after(:all) do
  	FileUtils::rm_rf("../bin/homework/ruby/test")	
  end
end
