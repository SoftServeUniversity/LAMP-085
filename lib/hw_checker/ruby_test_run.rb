module HomeWorkChecker
  module TestRunStat
    class RubyTestRun
      def initialize(tmp_path, dirname)
        @tmp_path, @dirname= tmp_path, dirname
        @passed = @failed = 0
      end

      def perform
        Dir.foreach("#{@tmp_path}/#{@dirname}/test") do |p|
          next unless File.file?("#{@tmp_path}/#{@dirname}/test/#{p}") && File.extname(p) == '.rb'
          `rspec #{@tmp_path}/#{@dirname}/test/#{p} > #{@tmp_path}/#{@dirname}/test/#{p}.tmp`
          count_passed_failed("#{@tmp_path}/#{@dirname}/test/#{p}.tmp")
        end
        calc_percent_passed
      end

      private
      def count_passed_failed(filename)
        report = File.open(filename).first.chomp
        return if report == 'No examples found.'
        report.each_char do |value|
          @passed += 1 if value == '.'
          @failed += 1 if value == 'F'
        end
      end

      def calc_percent_passed
        return 0.00 if @passed.zero? && @failed.zero?
        (@passed.to_f / (@passed + @failed) * 100).round(2)
      end
    end
  end
end
