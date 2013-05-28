module HomeWorkChecker
  module TestRunStat
    class PythonTestRun
      def initialize(tmp_path, dirname)
        @tmp_path, @dirname= tmp_path, dirname
        @passed = @failed = 0
      end

      def perform
        Dir.foreach("#{@tmp_path}/#{@dirname}/test/application") do |p|
          next unless File.file?("#{@tmp_path}/#{@dirname}/test/application/#{p}") && File.extname(p) == '.py'
          `python #{@tmp_path}/#{@dirname}/test/application/#{p} > #{@tmp_path}/#{@dirname}/test/#{p}.tmp`
          count_passed_failed("#{@tmp_path}/#{@dirname}/test/#{p}.tmp")
        end
        calc_percent_passed
      end

      private
      def count_passed_failed(filename)
        report.each_char do |value|
          @passed += 1 if value == '.'
          @failed += 1 if (value == 'F' || value == 'E')
        end
      end

      def calc_percent_passed
        return "0.00%" if @passed.zero? && @failed.zero?
        '%.2f%%' % (@passed.to_f / (@passed + @failed) * 100).round(2)
      end
    end
  end
end
