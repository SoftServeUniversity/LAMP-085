require "./unarchive.rb"

module Unarchive
	#
	# read WORK_PATH and detect archives
	#
	class ScanDir
	  def initialize
	    unless Dir.exist?(WORK_PATH)
	      raise "Directory #{WORK_PATH} does not exist"
	    end
	    unless Dir.exist?(DESTIN_PATH)
	      raise "Directory #{DESTIN_PATH} does not exist"
	    end

	    @archive_all = []
	  end

	  #
	  # return array contain names of archive files
	  #
	  def get_archives
	    Dir::foreach(WORK_PATH) do |p|
	      if File::file?("#{WORK_PATH}/#{p}") and 
	      	ARCHIVE_TYPES.include?(File::extname p)	
					@archive_all << p
	      end
	    end

	    @archive_all
	  end

	end
end