module HomeWorkChecker
  class Base
    include HomeWorkChecker 
    def initialize(work_path, tmp_path = '/tmp')
      raise "Working directory is not known" if work_path.nil?
      raise "Directory #{work_path} does not exist" unless Dir::exist?(work_path)
      raise "Directory #{tmp_path} does not exist" unless Dir::exist?(tmp_path)
      @work_path, @tmp_path = work_path, tmp_path
    end

    def start
      FileScan.new(@work_path).each do |name, type|
        `rm -r #{@tmp_path}/#{name}` if Dir::exist?("#{@tmp_path}/#{name}")
        Unarchive::Zip.new("#{@work_path}/#{name+type}", @tmp_path)
        class_name = LANGUAGE_TYPES[TestRun::detect_language "#{@tmp_path}/#{name}"]
        test_runner = class_name.new(@work_path, @tmp_path, name).perform
      end
    end  
  end
end
