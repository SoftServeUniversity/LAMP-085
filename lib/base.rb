module HomeWorkChecker
  class Base
    def initialize
    end

    def self.start
      file_scan = FileScan.new("../source")
      work_path, tmp_path = file_scan.work_path, file_scan.tmp_path
      file_scan.perform
      file_scan.each do |name, type|
        next if type == '.xml'
        dir_name = file_scan.destroy_directory(name.dup)
        FILE_TYPES[type].new(work_path, tmp_path, name).extract
        test_base = TestRun::TestBase.new("#{tmp_path}/#{dir_name}")
        LANGUAGE_TYPES[test_base.detect_language].new("#{tmp_path}/#{dir_name}").perform
        file_scan.destroy_directory(name.dup)
      end
    end
  end
end