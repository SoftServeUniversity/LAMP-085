module HomeWorkChecker
  class Copier < Base
    def file_manager  (f, work_path, tmp_path)
      homework = f.slice(/.*:/).slice(0..-2)
      student = f.slice(/:.*\./).slice(1..-2)
      puts folder_name = f.slice(/.*\./).slice(0..-2)
        type = File::extname(f)
        #next if type == '.xml'
        FileUtils::rm_rf("#{tmp_path}/.")
        FILE_TYPES[type].new(work_path, tmp_path, folder_name).extract
        for_rspec = Dir::entries(tmp_path).include?("#{folder_name}")
        test_base = TestRun::TestBase.new("#{tmp_path}/#{folder_name}")
        LANGUAGE_TYPES[test_base.detect_language].new("#{tmp_path}/#{folder_name}").perform
        FileUtils::rm_rf("#{tmp_path}/.")
        return for_rspec
		end
  end
end
