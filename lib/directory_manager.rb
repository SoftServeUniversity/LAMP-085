require 'rubygems'
#require 'zip/zip'

class DirectoryManager
	UNARCHIVE_TYPES = {'.7z' => "", '.zip' => ""}

	def initialize(path = "my_folder")
		@work_path = "/home/#{`whoami`.strip}/#{path}"
		@destin_path = "/tmp"
		@arch = []

		unless Dir.exist?(@work_path)
			raise "Directory #{@work_path} does not exist"
		end
		unless Dir.exist?(@destin_path)
			raise "Directory #{@destin_path} does not exist"
		end
	end

	
	def get_archives
		Dir::foreach(@work_path) do |p|
			if File::file?("#{@work_path}/#{p}") and 
				UNARCHIVE_TYPES.include?(File::extname p)
				@arch << p
			end
		end
	end

end