require 'rubygems'
require_relative '../lib/exec.rb'

describe Copier do
	describe '#ruby_or_scala' do
		it {subject.tmp_to_homework.should == "ruby" || "scala"}
	end
end

