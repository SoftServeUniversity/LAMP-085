module HomeWorkChecker
  class Base
    def initialize
    end

    def self.start
      file_scan = FileScan.new("../source")
      work_path, tmp_path = file_scan.work_path, file_scan.tmp_path
      file_scan.perform.each do |f|
        Copier.new.file_manager(f, work_path, tmp_path)
      end
    end
  end
end