module HomeWorkChecker
  class FileScan < Base
    attr_reader :work_path, :tmp_path

    def initialize(work_path, tmp_path = '../lib/tmp')
      @work_path, @tmp_path = work_path, tmp_path
      raise "Directory #{@work_path} does not exist" unless Dir::exist?(@work_path)
      FileUtils::mkdir_p("#{tmp_path}") unless Dir::exist?(@tmp_path)
    end

    def perform
      @files = []
      Dir::foreach(@work_path) do |p|
        if File::file?("#{@work_path}/#{p}") && FILE_TYPES.include?(File::extname p) && !exist_xml?(p.dup)
          @files << p
        end
      end
      @files
    end

    protected
    def exist_xml?(archive_name)
      extname_len = File::extname(archive_name).length
      extname_len.times { archive_name.chop! }
      File::exist? "#{@work_path}/#{archive_name}.xml"
    end
  end
end