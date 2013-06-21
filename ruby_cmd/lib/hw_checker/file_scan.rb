module HomeWorkChecker
  class FileScan
    def initialize(archive_path, result_path, tmp_path = '/tmp')
      raise DirectoryExistError, "Directory '#{archive_path}' does not exist" unless Dir::exist?(archive_path)
      raise DirectoryExistError, "Directory '#{result_path}' does not exist" unless Dir::exist?(result_path)
      raise DirectoryExistError, "Directory '#{tmp_path}' does not exist" unless Dir::exist?(tmp_path)
      @archive_path, @result_path, @tmp_path, @files = archive_path, result_path, tmp_path, []
      Dir.foreach(@archive_path) do |p|
        if File.file?("#{archive_path}/#{p}") && ARCHIVE_TYPES.include?(File.extname p) && !exist_xml?(p)
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

    private
    def exist_xml?(archive_name)
      name = archive_name.chomp(File.extname archive_name)
      File.exist? "#{@result_path}/#{name}.xml"
    end 
  end
end
