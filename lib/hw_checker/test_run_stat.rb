module HomeWorkChecker
  module TestRunStat
    def self.detect_language(path)
      return '.py' unless Dir.exist?("#{path}/test")
      Dir.foreach("#{path}/test") do |p|
        if File.file?("#{path}/test/#{p}") && LANGUAGE_TYPES.include?(File.extname p)
          return File.extname p
        end
      end
      raise "Any .rb/.py file doesn't exist"
    end

    def self.execute(work_path, tmp_path, dirname)
      class_names = LANGUAGE_TYPES[TestRunStat::detect_language("#{tmp_path}/#{dirname}")]
      test_passed = class_names.first.new(tmp_path, dirname).perform
      code_quality = class_names.last.new(tmp_path, dirname).perform      
      [test_passed, code_quality]
    end
  end
end
