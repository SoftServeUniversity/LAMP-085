module HomeWorkChecker
  class FileScan
    def initialize(work_path)
      @work_path, @files = work_path, []
      Dir.foreach(@work_path) do |p|
        if File.file?("#{@work_path}/#{p}") && FILE_TYPES.include?(File.extname p) && !exist_xml?(p)
          @files << p
        end
      end
    end

    def each
      if block_given?
        i = 0
        while i < @files.size
          type = File.extname(@files[i])
          name = @files[i].chomp(type)
          yield(name, type)
          i += 1
        end 
      end
      @files
    end

    def self.detect_studname(dirname)
      dirname.split(':').last
    end

    private
    def exist_xml?(archive_name)
      temp = archive_name.chomp(File.extname archive_name)
      File.exist? "#{@work_path}/#{temp}-result.xml"
    end 
  end
end
