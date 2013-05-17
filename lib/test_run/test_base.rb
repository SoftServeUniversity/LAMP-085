module HomeWorkChecker
  module TestRun
    class TestBase
      def initialize(path)
        @path = path
        raise "Subdirectory 'test' don't exist in folder #{@path}" unless Dir::exist?("#{@path}/test")
      end

      def detect_language
        Dir::foreach("#{@path}/test") do |p|
          if File::file?("#{@path}/test/#{p}") && LANGUAGE_TYPES.include?(File::extname p)
            return File::extname p
          end
        end
        raise "Any .rb/.py file doesn't exist"
      end
    end
  end
end 