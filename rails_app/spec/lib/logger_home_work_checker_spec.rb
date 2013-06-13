require File.expand_path('lib/loggers/logger_home_work_checker')

module OwnLogger
  describe HomeWorkChecker do
    before(:each) do
      path = File.expand_path('spec/support')
      @logger = HomeWorkChecker.new(path)
    end
    
    describe '.new' do
      it 'should initialize log path correctly' do
        @logger.path.should == File.expand_path('spec/support')
      end
      it 'should determinate log file depend on year/month' do
        date = Time.now.to_s[0..6]
        @logger.instance_variable_get(:@curr_fn).should ==
          'home_work_check_' + date + '.log'
      end
    end

    describe '#add_line' do
    end
  end
end