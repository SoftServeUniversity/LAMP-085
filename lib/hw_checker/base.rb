module HomeWorkChecker
  class Base
    def self.start(work_path, tmp_path, name, type)
      `rm -r #{tmp_path}/#{name}` if Dir.exist?("#{tmp_path}/#{name}")
      Unarchive::Zip.new("#{work_path}/#{name+type}", tmp_path)
      TestRunStat::execute(work_path, tmp_path, name)
    end  
  end
end
