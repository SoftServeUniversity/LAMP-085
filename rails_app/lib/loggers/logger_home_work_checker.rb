module OwnLogger
  class HomeWorkChecker
    attr_reader :path

    def initialize(path = 'log')
      @path = path
      @curr_fn = 'home_work_check_' + Time.now.to_s[0..6] + '.log'
    end

    def add_line(msg)
      File.open("#{@path}/#{@curr_fn}", 'a') do |file|
        file.write("#{Time.now}: #{msg}\n")
      end
    end

    def find_files_to_download
      year, years, months = Time.now.to_s[0..3].to_i, [], []
      pattern_archive = /^home_work_check_\d{4}.7z$/i
      pattern_log = /^home_work_check_#{year}-\d{2}.log$/i
      Dir.foreach(@path) do |p|
        if File.file?("#{@path}/#{p}")
          years << p.scan(/\d+/).first if p =~ pattern_archive
          ( years << year.to_s; months << p.scan(/\d+/).last ) if p =~ pattern_log        
        end
      end
      [years.uniq.sort, months.uniq.sort]
    end

    def compress_files(year)
      log_files = find_files_to_compress(year).join(' ')
      %x|'7z a "#{@path}/home_work_check_#{year}.7z #{log_files}"|
      log_files.split(' ').each { |f| %x|rm "#{f}"| }
    end

    private
    def find_files_to_compress(year)
      pattern, files = /^home_work_check_#{year}-\d{2}.log$/i, []
      Dir.foreach(@path) do |p|
        if File.file?("#{@path}/#{p}") && p =~ pattern
          files << "#{@path}/#{p}"
        end
      end
      files
    end
  end
end
