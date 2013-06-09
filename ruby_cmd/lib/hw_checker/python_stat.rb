module HomeWorkChecker
  module TestRunStat
    class PythonStat
      def initialize(tmp_path, dirname)
        @work_path = "#{tmp_path}/#{dirname}/tests/statistic"
        raise DirectoryExistError, "Archive '#{dirname}' is invalid" unless Dir::exist?(@work_path)
        @lines_all = @lines_failed = 0
      end

      def perform
        result = 0
        Dir.foreach(@work_path) do |p|
          next unless File.file?("#{@work_path}/#{p}") && File.extname(p) == '.py' && p != '__init__.py'
          `pylint #{@work_path}/#{p} > #{@work_path}/#{p}.tmp 2>&1`
          result = calc_percent_quality("#{@work_path}/#{p}.tmp")
        end
        result
      end

      def calc_percent_quality(filename)
        ( (`tail -n 2 #{filename}`).scan(/\d{1,2}/).shift.to_f / 10 * 100).round(2)
      end
    end
  end
end
