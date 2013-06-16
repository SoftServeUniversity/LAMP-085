require File.expand_path('lib/loggers/logger_home_work_checker')

module OwnLogger
  describe HomeWorkChecker do
    before(:each) do
      @path = File.expand_path('spec/support')
      @logger = HomeWorkChecker.new(@path)
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
      it 'should write out correct amount of byte' do
        logger = double(@logger)
        logger.stub(:add_line).with('some_message').and_return(12)
        logger.add_line('some_message').should == 12
      end

      it 'should open log file once' do
        file = mock('file')
        File.should_receive(:open).and_yield(file)
        file.should_receive(:write).with("#{Time.now}: some_message\n")
        @logger.add_line('some_message')
      end
    end

    describe '#find_files_to_download' do
      it "should yield all directory's item" do
        path = mock('path')
        Dir.should_receive(:foreach).with(@logger.path).once.and_yield(path)
        @logger.find_files_to_download
      end
      it 'should return correct 2d-array' do
        @logger.find_files_to_download.should == [['2012', '2013'], ['06', '09']]
      end
    end

    describe '#compress_files' do
    end
 
    describe '#find_files_to_compress' do
      it "should yield all directory's item" do 
        path = mock('path')
        Dir.should_receive(:foreach).with(@logger.path).once.and_yield(path)
        @logger.send(:find_files_to_compress, 2013)
      end
      it 'should return correct amount of log file' do
        @logger.send(:find_files_to_compress, 2013).count.should == 2
      end
    end
  end
end
