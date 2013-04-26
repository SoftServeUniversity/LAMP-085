require 'rubygems'
require_relative '../lib/directory_manager'

RSpec.configure do |config|
  config.tty = true
  config.color = true
end

describe DirectoryManager do
  describe '#get_archives' do
    before(:each) do
      @object = DirectoryManager.new("LAMP-085/support/")
    end
    it 'return names of work directory archive files' do
      @object.get_archives
      @object.instance_variable_get(:@arch).should have(6).items
    end
  end
end