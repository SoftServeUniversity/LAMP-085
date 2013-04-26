require 'rubygems'
require_relative '../lib/DirectoryManager'

describe DirectoryManager do
	describe '#to_s' do
		before(:each) do
			@object = DirectoryManager.new
		end
		it 'return empty' do
			@object.to_s.should eq "[]\n[]"
		end
	end
end