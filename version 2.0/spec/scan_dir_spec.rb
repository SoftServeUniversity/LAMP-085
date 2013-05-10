require 'rubygems'
require_relative '../lib/scan_dir'


describe Unarchive::ScanDir do
  describe '#exist' do
    before(:each) do
      scan_dir = Unarchive::ScanDir.new
      @result = scan_dir.send(:exist?, 'a.txt.7z')
    end
=begin
    it 'should remove extension name' do
      @result.should == 'a.txt'
    end
=end
    it 'item should exist in DESTIN_PATH' do
      @result.should be_true
    end
  end
end 