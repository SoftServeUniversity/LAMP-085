require 'resque_spec'
require 'spec_helper'

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
      @res_file = File.expand_path("spec/models/julia.tymo_creational.patterns-result.xml")
    end

    it "store data from xml-file to database" do
      xml_content = Report.send( :xml_file_to_hash, @res_file)
      xml_content.class.should == Hash

      s = FactoryGirl.build_stubbed(:student, name: xml_content[:student])
      s.name.should == "julia.tymo"

      h = FactoryGirl.build_stubbed(:homework,
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
      r.homework_id.should == 1002
      r.student_id.should == 1001
      r.ratio.should == 0.0
      r.quality == 67.23
      r.time == 1.23

    end

    describe ".home_work_check"
      before(:each) do
        ResqueSpec.reset!
        @res_path = "../spec/models"
        @checker = Report.home_work_check
      end
    it "puts files into Resque queue"
      double(HomeWorkChecker::FileScan.new(@res_path, '/tmp')).stub(:each)
        and_yield( 'julia.tymo_creational.patterns','.7z')
        Resque.enqueue(ArchiveChecker, @res_path, '/tmp', name, type)
      
      ArchiveChecker.should have_queue_size_of(1)
  # it { should validate_uniqueness_of(:title) }
  # it { should validate_uniqueness_of(:title).scoped_to(:user_id, :category_id) }
  # it { should validate_presence_of(:body).with_message(/wtf/) }
  # it { should validate_presence_of(:title) }
  # it { should validate_numericality_of(:user_id) }
  # it { should ensure_inclusion_of(:status).in_array(['draft', 'public']) }
end

