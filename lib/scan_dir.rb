require_relative "./unarchive"

module Unarchive
  #
  # read WORK_PATH and detect archives
  #
  class ScanDir
    def initialize
      raise "Directory #{WORK_PATH} does not exist" unless Dir.exist?(WORK_PATH)
      raise "Directory #{DESTIN_PATH} does not exist" unless Dir.exist?(DESTIN_PATH)

      @archive_all = []
    end

    #
    # return array contain names of archive files
    #
    def get_archives
      @archive_all.clear

      Dir::foreach(WORK_PATH) do |p|
        if File::file?("#{WORK_PATH}/#{p}") && ARCHIVE_TYPES.include?(File::extname p)  #&& !self.exist?(p.dup)
          @archive_all << p
        end
      end

      @archive_all
    end


    protected
    #
    # check if item contains in DESTIN_PATH
    #
    def exist?(archive_path)
      size = File::extname(archive_path).length
      size.times { archive_path.chop! }

      Dir::foreach(DESTIN_PATH) do |p|
        return true if p == archive_path
      end
      false
    end
    
  end
end
