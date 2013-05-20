require 'rubygems'
require_relative '../lib/hw_checker'

describe HomeWorkChecker::Unarchive::SevenZip do
  before(:each) do
    @work_path = '../source'
    @filename = 'homework-900:tarasov.7z'
    @tmp_path = '/tmp/'
    @unarchive1 = HomeWorkChecker::Unarchive::SevenZip.new(@work_path, @tmp_path, @filename).extract    
  end

  after(:each) do
    `rm -rf #{@tmp_path}/#{@filename.chomp(".7z")}`
  end

  it 'should exist in temp' do
    Dir.exist?("#{@tmp_path}/#{@filename.chomp(".7z")}").should be_true
  end

  it 'authenticity archive' do
    @authenticity = `7za t #{@work_path}/#{@filename}`
    @authenticity = @authenticity.include? "Everything is Ok"
    @authenticity.should be_true
  end
end

