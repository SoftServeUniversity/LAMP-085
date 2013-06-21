module HomeWorkChecker
  module ArchiveResult
    class RubyTestRun < TestRun
      def initialize(tmp_path, dirname)
        @work_path = "#{tmp_path}/#{dirname}/test"
        raise DirectoryExistError, "Archive '#{dirname}' is invalid" unless Dir::exist?(@work_path) 
        @passed = @failed = 0
      end

      def perform
        Dir.foreach(@work_path) do |p|
          next unless File.file?("#{@work_path}/#{p}") && File.extname(p) == '.rb'
          `rspec #{@work_path}/#{p} > #{@work_path}/#{p}.tmp`
          count_passed_failed("#{@work_path}/#{p}.tmp")
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
