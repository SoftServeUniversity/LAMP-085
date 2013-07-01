require 'resque_spec'
require 'spec_helper'
require File.expand_path "app/workers/archive_checker"

describe Report do
  it { should belong_to(:student) }
  it { should belong_to(:homework) }
  it { should validate_presence_of(:quality) }
  it { should validate_presence_of(:ratio) }
  it { should validate_presence_of(:time) }
  it { should validate_numericality_of(:quality) }
  it { should validate_numericality_of(:ratio) }
  it { should validate_numericality_of(:time) }

  it "is invalid without a name" do
    FactoryGirl.build(:report, quality: 102).should_not be_valid
  end

  let(:time_start) {Time.now}
  let(:report) { }
  describe ".add_record"
    before (:each) do
      @res_file = File.expand_path("spec/support/julia.tymo_creational.patterns-result.xml")
    end

    it "store data from xml-file to database" do
      xml_content = Report.send( :xml_file_to_hash, @res_file)
      xml_content.class.should == Hash

      s = FactoryGirl.create(:student, name: xml_content[:student])
      s.name.should == "julia.tymo"

      h = FactoryGirl.create(:homework,
        title: xml_content[:homework],
        language: xml_content[:language])
      h.title.should == "creational.patterns"
      h.language == "ruby"

      r = FactoryGirl.create(:report,
        homework_id: h.id,
        student_id: s.id,
        ratio: xml_content[:ratio],
        quality: xml_content[:quality],
        time: xml_content[:time])
      r.homework_id.should == 1
      r.student_id.should == 1
      r.ratio.should == 0.0
      r.quality.should == 28.57
      r.time.should == 1.3

    end

    describe ".homework_check" do
      before(:each) do
        ResqueSpec.reset!
        @arch_path = Rails.root.join('spec','support','archives')
        @res_path = Rails.root.join('spec','support','results')
        @checker = Report.homework_check
        @logger = OwnLogger::HomeWorkChecker.new File.expand_path('log')
      end
      context "when all is fine" do
        it "puts files into Resque queue" do
          Resque.should_receive(:enqueue).with(any_args()) 
          ArchiveChecker.should have_queue_size_of(1)
        end
      end

      context "when something went wrong" do
        it "raise exeption" do
          expect {
            HomeWorkChecker::FileScan.new("WRONG_PATH", '/tmp')
          }.to raise_error(HomeWorkChecker::DirectoryExistError)
        end
        it "pass through rescue block" do
          # @logger.should_receive(:add_line).once
          scan = double(HomeWorkChecker::FileScan)
          scan.stub(:new).and_raise(HomeWorkChecker::DirectoryExistError)
          Report.homework_check
        end
      end
    end

    describe ".archive_passed" do
      it "contain string " do
        Report.archive_passed("bla-bla").should 
          eq "Archive bla-bla have successfully processed"
      end
    end

    describe ".archive_failed" do
      it "contain string " do
        Report.archive_failed("bla-bla").should 
          eq "Archive bla-bla have failed. Something went wrong"
      end
    end

    describe ".find_files_to_download" do
      it "call loger method" do
        @logger.stub(:find_files_to_download).and_return([])
        Report.find_files_to_download
      end
    end

    describe ".compress_log_files" do
      it "call loger method" do
        @logger.stub(:compress_log_files).with(2013).and_return('')
        Report.compress_log_files
      end
    end
  end
end
