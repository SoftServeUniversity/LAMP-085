require 'rubygems'
require '../lib/unarchive'
require_relative '../lib/seven_zip'

describe Unarchive::SevenZip do
  before(:each) do
    @dirname = Unarchive::TMP_PATH
    @filename = 'homework-600:anonim.7z'
    @name_student = 'anonim'
    @archive_path = Unarchive::WORK_PATH
    @unarchive1 = Unarchive::SevenZip.new(@filename, @name_student).extract    
  end

  after(:each) do
    `rm -rf #{@dirname}/#{@name_student}/#{@filename.delete '.7z'}`
  end

  it 'should exist in temp' do
    Dir.exist?("#{@dirname}/#{@name_student}/#{@filename.delete '.7z'}").should be_true
  end

  it 'authenticity archive' do
    @authenticity = `7za t #{@archive_path}/#{@filename}`
    @authenticity = @authenticity.include? "Everything is Ok"
    @authenticity.should be_true
  end
end

