module HomeWorkChecker
  module TestRunStat
    class PythonStat
      def initialize(tmp_path, dirname)
        @tmp_path, @dirname= tmp_path, dirname
        @lines_all = @lines_failed = 0
      end

      def perform
        Dir.foreach("#{@tmp_path}/#{@dirname}") do |p|
          next unless File::file?("#{@tmp_path}/#{@dirname}/#{p}") && File.extname(p) == '.py'
          `pylint #{@tmp_path}/#{@dirname}/#{p} > #{@tmp_path}/#{@dirname}/#{p}.tmp  2>&1`
        end
        calc_percent_quality
      end

      def calc_percent_quality(filename)
        test_line = '' ; res = '' ; rake = 0
        test_line = `tail -n 2 result.txt`
        res = test_line.scan(/\d{1,2}/)
        rake = res.shift.to_f
        (( rake/10 ) * 100 )
      end
    end
  end
end
