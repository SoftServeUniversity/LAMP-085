module HomeWorkChecker
  module TestRunStat
    class PythonStat
      def initialize(tmp_path, dirname)
        @tmp_path, @dirname= tmp_path, dirname
        @lines_all = @lines_failed = 0
      end

      def perform
        result = 0
        Dir.foreach("#{@tmp_path}/#{@dirname}/tests/statistic") do |p|
          next unless File.file?("#{@tmp_path}/#{@dirname}/tests/statistic/#{p}") && File.extname(p) == '.py' && p != '__init__.py'
          `pylint #{@tmp_path}/#{@dirname}/tests/statistic/#{p} > #{@tmp_path}/#{@dirname}/tests/statistic/#{p}.tmp 2>&1`
          result = calc_percent_quality("#{@tmp_path}/#{@dirname}/tests/statistic/#{p}.tmp")
        end
        result
      end

      def calc_percent_quality(filename)
        ( (`tail -n 2 #{filename}`).scan(/\d{1,2}/).shift.to_f / 10 * 100).round(2)
      end
    end
  end
end
