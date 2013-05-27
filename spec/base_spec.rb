require_relative '../lib/hw_checker'

module HomeWorkChecker
  describe Base do
    before(:each) do
      @archives = ['aaa.zip', 'bbb.7z']
      @work_path = './support/'
      @tmp_path = './support/tmp'
      @baza = HomeWorkChecker::Base.new(@work_path)
    end
    context '#start' do
      it 'extracting should execute 5 times' do
        files_to = double("FileScan", :work_path => @work_path) 
        files_to.stub(:files).and_return(@archives)

        szip_files = stub("HomeWorkChecker::Unarchive::Zip")
        szip_files.should_receive(:new).with("aaa.zip", @tmp_path).once
        szip_files.should_receive(:new).with("bbb.7z", @tmp_path).once

        run_files = double("HomeWorkChecker::TestRunStat")
        run_files.stub(:detect_language).with("#{@tmp_path}/task1").and_return(".rb")
        rtr = stub(LANGUAGE_TYPES[run_files.detect_language "#{@tmp_path}/task1"])
        rtr.should_receive(:new).with("#{@tmp_path}/task1").once
      
        files_to.stub(:each).
          and_yield(stub(szip_files.new(files_to.files[0], @tmp_path)),
                    stub(rtr.new("#{@tmp_path}/task1"))).
            and_yield(stub(szip_files.new(files_to.files[1], @tmp_path)))
      end
    end
  end
end
