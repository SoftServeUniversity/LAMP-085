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
      lang_needed = TestRunStat::detect_language("#{tmp_path}/#{dirname}")
      class_names = LANGUAGE_TYPES[lang_needed]
      test_passed = class_names.first.new(tmp_path, dirname).perform
      code_quality = class_names.last.new(tmp_path, dirname).perform      
      [name_language(lang_needed), test_passed, code_quality]
    end

    def self.name_language(extname)
      extname == '.rb' ? 'ruby' : 'python' 
    end
  end
end
