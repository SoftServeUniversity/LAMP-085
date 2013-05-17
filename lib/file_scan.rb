module HomeWorkChecker
  class FileScan < Base
    attr_reader :work_path, :tmp_path

    def initialize(work_path, tmp_path = '/tmp')
      @work_path, @tmp_path = work_path, tmp_path
      raise "Directory #{@work_path} does not exist" unless Dir::exist?(@work_path)
      raise "Directory #{@tmp_path} does not exist" unless Dir::exist?(@tmp_path)
    end

    def perform
      @files = []
      Dir::foreach(@work_path) do |p|
        if File::file?("#{@work_path}/#{p}") && FILE_TYPES.include?(File::extname p) && !exist_xml?(p.dup)
          @files << p
        end
      end
    end

    def each
      if block_given?
        i = 0
        while i < @files.size
          yield(@files[i], File::extname(@files[i]) )
          i += 1  
        end
      end
      @files
    end

    def destroy_directory(archive_name)
      extname_len = File::extname(archive_name).length
      extname_len.times { archive_name.chop! }
      FileUtils::remove_dir("#{@tmp_path}/#{archive_name}") if Dir::exist?("#{@tmp_path}/#{archive_name}")
      archive_name
    end

    protected
    def exist_xml?(archive_name)
      return false if File::extname(archive_name) == '.xml' 
      extname_len = File::extname(archive_name).length
      extname_len.times { archive_name.chop! }
      File::exist? "#{@work_path}/#{archive_name}.xml"
    end
  end
end