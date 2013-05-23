module HomeWorkChecker
  module TestRun
    def self.detect_language(path)
      raise "Subdirectory 'test' don't exist in folder #{path}" unless Dir::exist?("#{path}/test")
      Dir::foreach("#{path}/test") do |p|
        if File::file?("#{path}/test/#{p}") && LANGUAGE_TYPES.include?(File::extname p)
          return File::extname p
        end
      end
      raise "Any .rb/.py file doesn't exist"
    end

    def generate_xml(path, hash)
      File.open("#{path}.xml", 'w') do |file| 
        file.write hash.to_xml
      end
    end
  end
end
