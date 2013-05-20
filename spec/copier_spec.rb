require 'rubygems'
require_relative '../lib/file_manager'
require_relative '../lib/hw_checker'

describe HomeWorkChecker::Base do
  it '#is folder unurchived ?' do
  	item = HomeWorkChecker::Copier.new("homework-500:petrov.zip", work_path, work_path)
    item.file_manager.should == true
  end
end


