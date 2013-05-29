module HomeWorkChecker
  module TestRunStat
    class RubyStat
      def initialize(tmp_path, dirname)
        @tmp_path, @dirname= tmp_path, dirname
        @lines_all = @lines_failed = 0
      end

      def perform
        Dir.foreach("#{@tmp_path}/#{@dirname}") do |p|
          next unless File::file?("#{@tmp_path}/#{@dirname}/#{p}") && File.extname(p) == '.rb'
          `rubocop #{@tmp_path}/#{@dirname}/#{p} > #{@tmp_path}/#{@dirname}/#{p}.tmp`
          count_lines_failed("#{@tmp_path}/#{@dirname}/#{p}.tmp")
          count_lines_all("#{@tmp_path}/#{@dirname}/#{p}")
        end
        calc_percent_quality
      end

      def count_lines_failed(filename)
        temp = []
        File.open(filename).each_line do |line|
          next unless line.match(/[CW]:\s+\d+:\s+[\w\W]{4,}/)
          temp << line.scan(/\d+/).first.to_i
        end
        @lines_failed += temp.uniq.size
      end

      def count_lines_all(filename)
        File.open(filename).each_line { @lines_all += 1 }        
      end

      def calc_percent_quality
        return '0.00%' if @lines_all.zero?
        '%.2f%%' % ( (1.0 - @lines_failed.to_f / @lines_all) * 100)
      end
    end
  end
end
