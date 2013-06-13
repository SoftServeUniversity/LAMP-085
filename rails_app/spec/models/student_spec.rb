require 'spec_helper'

describe Student do
  it { should have_many :reports }
  it { should have_many(:homeworks).through(:reports) }

  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:name).with_message(/^[a-z]+.[a-z]+$/i) }

  it "save information from xml to student table" do
    xml_file = File.expand_path("spec/support/julia.tymo_creational.patterns-result.xml")
    xml_data = Report.send( :xml_file_to_hash, xml_file)
    xml_data.class.should == Hash

    s = FactoryGirl.create(:student, name: xml_data[:student])
    s.name.should == "julia.tymo"
  end
end
