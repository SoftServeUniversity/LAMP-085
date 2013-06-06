module OwnLogger
  class HomeWorkChecker
    attr_reader :path, :curr_fn

    def initialize
      @path = File.expand_path('log')
      @curr_fn = 'home_work_check_' + Time.now.to_s.first(7) + '.log'
    end

    def add_line(msg)
      File.open("#{@path}/#{@curr_fn}", 'a') do |file|
        file.write("#{Time.now}: #{msg}\n")
      end
    end
  end
end