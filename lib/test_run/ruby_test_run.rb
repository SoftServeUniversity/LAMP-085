module HomeWorkChecker
  module TestRun
    class RubyTestRun < TestBase
      def initialize(path)
        super
      end

      def perform
        Dir::foreach("#{@path}/test") do |p|
          next unless File::file?("#{@path}/test/#{p}") && File::extname(p) == '.rb'
          puts `rspec #{@path}/test/#{p}`          
        end
      end
    end
  end
end 