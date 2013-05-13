require 'rubygems'
require_relative '../lib/file_manager'

describe FileManager::Copier do
  describe '#ruby_or_scala' do
    it {subject.tmp_to_homework.should == "ruby" || "scala"}
  end
end

