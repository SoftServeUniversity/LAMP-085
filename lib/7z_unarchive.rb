require 'fileutils.rb'
class Zipper
	attr_reader :temp_folder, :archive_name
	def initialize (temp_folder = '/home/red4ik/rubitest/', archive_name = '1.7z')
		@temp_folder = temp_folder
		@archive_name = archive_name
	end

	def zip_unarhive
		Dir.chdir("#{@temp_folder}")
		system "7zr x '#{@archive_name}'"
	end
end