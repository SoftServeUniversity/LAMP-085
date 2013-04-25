require 'rubygems'
require 'pathname'

class DirectoryManager
	def initialize home_path = "/home/jazu4nuk/dir/" 
		@home_path = home_path
		@home_path_folders = []
		@home_path_files = []
		
	end

	def to_s
		"#{@home_path_folders}\n#{@home_path_files}"
	end

	def get_root_temporary_directory
		@temp_root = Pathname.new ENV['TEMP'] || ENV['TMP'] || '/tmp'
		raise "Can't find a temp directory" unless temp_root.exist?
	end

	def scan_dir
		unless Dir.exist? @home_path
			puts "Wrong directory" 
			return
		end
		Dir.foreach @home_path do |files|
  		if File.directory? ("#{@use_dir}#{files}") 
        @home_path_folders << files
      else
        @home_path_files << files 
      end
  	end
	end

	def is_zip? filename
		File.extname(filename) == ".zip"
	end

	def is_7z? filename
		File.extname(filename) == ".7z"
	end

end

