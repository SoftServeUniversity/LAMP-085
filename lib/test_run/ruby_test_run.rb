module HomeWorkChecker
  module TestRun
    class RubyTestRun
      include TestRun

      def initialize(work_path, tmp_path, dirname)
        @work_path, @tmp_path = work_path, tmp_path
        @dirname, @passed, @failed = dirname, 0, 0
      end

      def perform
        Dir::foreach("#{@tmp_path}/#{@dirname}/test") do |p|
          next unless File::file?("#{@tmp_path}/#{@dirname}/test/#{p}") && File::extname(p) == '.rb'
          `rspec #{@tmp_path}/#{@dirname}/test/#{p} > #{@tmp_path}/report.txt`
          count_passed_failed(File.open("#{@tmp_path}/report.txt").first.chomp)
        end
        generate_xml("#{@work_path}/#{@dirname}", {
          :test_passing => calc_percent_passed,
          :code_quality => '???'
        })
      end

      private
      def count_passed_failed(report)
        return if report == 'No examples found.'
        report.each_char do |value|
          @passed += 1 if value == '.'
          @failed += 1 if value == 'F'
        end
      end

      def calc_percent_passed
        return 0.00 if @passed.zero? && @failed.zero?
        (@passed.to_f / ( @passed + @failed) * 100).round(2)
      end
    end
  end
end
