require 'rubygems'
require_relative '../lib/hw_checker'

describe HomeWorkChecker::FileScan do
  before(:each) do
    @file_scan = HomeWorkChecker::FileScan.new("../source")
  end

  context '#perform' do
    before(:each) do
      @file_scan.perform
    end
    def is_all_archives?
      @file_scan.instance_variable_get(:@files).each do |item; ext_name|
        ext_name = File::extname(item)
        return false unless HomeWorkChecker::FILE_TYPES.include?(ext_name)
      end
      true
    end
    it 'should have exactly 5 items' do
      @file_scan.instance_variable_get(:@files).should have(5).items 
    end
    it 'should contain .zip/7z files only' do
      is_all_archives?.should_not be_false
    end
  end

  context '#each' do
    before(:each) do
      @file_scan.perform
      @file_scan.instance_variable_get(:@files).sort!
    end
    it 'should yield correct data' do
      expect { |b| @file_scan.each(&b) }.to yield_successive_args(
        ["homework-500:ivanov.7z", ".7z"],
        ["homework-500:petrov.zip", ".zip"],
        ["homework-500:sidorov.zip", ".zip"],
        ["homework-700:sidorov.zip", ".zip"],
        ["homework-900:tarasov.7z", ".7z"]
      )
    end
  end

  context '#destroy_directory' do
    before(:each) do
      `mkdir #{@file_scan.tmp_path}/some_name`
      @file_scan.destroy_directory('some_name')
    end
    it 'directory should be removed' do
      Dir::exist?("{@file_scan.tmp_path}/some_name").should be_false
    end
  end

  context '#exist_xml?' do
    it 'xml-file should exist' do
      @file_scan.should_not be_exist_xml('test.xml')
    end
  end  

end
 