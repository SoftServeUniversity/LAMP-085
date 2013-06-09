module OwnLogger
  class HomeWorkChecker
    attr_reader :path, :curr_fn

    def initialize
      @path, @files = File.expand_path('log'), []
      @curr_fn = 'home_work_check_' + Time.now.to_s.first(7) + '.log'
    end

    def add_line(msg)
      File.open("#{@path}/#{@curr_fn}", 'a') do |file|
        file.write("#{Time.now}: #{msg}\n")
      end
    end

    def compress_files(year)
      log_files = find_files(year).join(' ')
      %x|7z a #{@path}/home_work_check_#{year}.7z #{log_files}|
      remove_files
    end

    private
    def find_files(year)
      pattern = /^home_work_check_#{year}-\d{2}.log$/i
      Dir.foreach(@path) do |p|
        if File.file?("#{@path}/#{p}") && p =~ pattern
          @files << "#{@path}/#{p}"
        end
      end
      @files
    end

    def remove_files
      @files.each do |f|
        %x|rm #{f}|
      end
    end
  end
end
