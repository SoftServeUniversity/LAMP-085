require 'rubygems'
require_relative '../lib/hw_checker'

describe HomeWorkChecker::Unarchive::StandartZip do
  before(:each) do
    @work_path = '../source'
    @filename = 'homework-500:sidorov.zip'
    @tmp_path = '/tmp/'
    @unarchive1 = HomeWorkChecker::Unarchive::StandartZip.new(@work_path, @tmp_path, @filename).extract    
  end

  after(:each) do
    `rm -rf #{@tmp_path}/#{@filename.chomp(".zip")}`
  end

  it 'should exist in temp' do
    Dir.exist?("#{@tmp_path}/#{@filename.chomp(".zip")}").should be_true
  end
end

