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

    def self.generate_xml(test_passed_per, code_quality_per)
      Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
        xml.root {
          xml.test_passed test_passed_per
          xml.code_quality code_quality_per
        }
      end.to_xml
    end

    def self.execute(work_path, tmp_path, dirname)
      class_names = LANGUAGE_TYPES[TestRunStat::detect_language("#{tmp_path}/#{dirname}")]
      test_passed = class_names.first.new(tmp_path, dirname).perform
      code_quality = class_names.last.new(tmp_path, dirname).perform      
      File.open("#{work_path}/#{dirname}-result.xml", 'w') do |file| 
        file.write TestRunStat::generate_xml(test_passed, code_quality)
      end
      {
        :failed_passed_ratio => test_passed,
        :code_quality => code_quality
      }
    end
  end
end
