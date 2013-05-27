module HomeWorkChecker
  class Base
    include HomeWorkChecker 
    def initialize(work_path, tmp_path = '/tmp')
      raise "Working directory is not set" if work_path.nil?
      raise "Directory #{work_path} does not exist" unless Dir::exist?(work_path)
      raise "Directory #{tmp_path} does not exist" unless Dir::exist?(tmp_path)
      @work_path, @tmp_path = work_path, tmp_path
    end

    def start
      FileScan.new(@work_path).each do |name, type|
        `rm -r #{@tmp_path}/#{name}` if Dir.exist?("#{@tmp_path}/#{name}")
        Unarchive::Zip.new("#{@work_path}/#{name+type}", @tmp_path)
        TestRunStat::execute(@work_path, @tmp_path, name)
      end
    end  
  end
end
