require File.expand_path './spec/spec_helper'
require File.expand_path './lib/hw_checker'

describe HomeWorkChecker::Unarchive::Zip do
  before(:each) do
    @path = File.expand_path('./spec/support')
    @fname = 'christina.berglund_py_order.administrator.7z'
  end

  after(:each) do
    `rm -rf #{@path}/#{@fname.chomp('.7z')}`
  end

  it 'should exist in temp' do
    @unarchive1 = HomeWorkChecker::Unarchive::Zip.new("#{@path}/#{@fname}", @path)
    Dir.exist?("#{@path}/#{@fname.chomp('.7z')}").should be_true
  end

  it 'authenticity archive' do
    @authenticity = `7za t #{@path}/#{@fname}`
    @authenticity = @authenticity.include? "Everything is Ok"
    @authenticity.should be_true
  end

  it 'exit code' do
    @unarchive1 = HomeWorkChecker::Unarchive::Zip.new("#{@path}/#{@fname}", @path)
    $?.to_s[-1].to_i.should equal(0)    
  end
end
