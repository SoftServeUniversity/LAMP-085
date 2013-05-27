require_relative '../lib/hw_checker'

describe HomeWorkChecker::Unarchive::Zip do
  before(:each) do
    @path_filename = './support/homework-900:tarasov.7z'
    @filename = 'homework-900:tarasov.7z'
    @tmp_path = '/tmp/support/'
  end

  after(:each) do
    `rm -rf #{@tmp_path}/#{@filename.chomp(".7z") || filename.chomp(".zip")}`
  end

  it 'should exist in temp' do
    @unarchive1 = HomeWorkChecker::Unarchive::Zip.new(@path_filename, @tmp_path)
    Dir.exist?("#{@tmp_path}/#{@filename.chomp(".7z") || filename.chomp(".zip")}").should be_true
  end

  it 'authenticity archive' do
    @authenticity = `7za t #{@path_filename}`
    @authenticity = @authenticity.include? "Everything is Ok"
    @authenticity.should be_true
  end

  it 'exit code' do
    @unarchive1 = HomeWorkChecker::Unarchive::Zip.new(@path_filename, @tmp_path)
    $?.to_s[-1].to_i.should equal(0)    
  end
end
