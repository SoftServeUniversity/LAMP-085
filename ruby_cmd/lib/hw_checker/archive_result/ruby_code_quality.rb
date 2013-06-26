module HomeWorkChecker
  module ArchiveResult
    class RubyCodeQuality < AbstractCodeQuality
      def initialize(tmp_path, dirname)
        @work_path = "#{tmp_path}/#{dirname}" 
        raise DirectoryExistError, "Archive '#{dirname}' is invalid" unless Dir::exist?(@work_path)
        @lines_all = @lines_failed = 0
      end

      def perform
        Dir.foreach(@work_path) do |p|
          next unless File::file?("#{@work_path}/#{p}") && File.extname(p) == '.rb'
          `rubocop #{@work_path}/#{p} > #{@work_path}/#{p}.tmp`
          count_lines_failed("#{@work_path}/#{p}.tmp")
          count_lines_all("#{@work_path}/#{p}")
        end
        calc_percent_quality
      end

      private
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
        return 0.00 if @lines_all.zero?
        ( (1.0 - @lines_failed.to_f / @lines_all) * 100).round(2)
      end
    end
  end
end
