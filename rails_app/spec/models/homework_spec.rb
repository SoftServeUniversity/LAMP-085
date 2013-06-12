require 'spec_helper'

describe Homework do
  it { should have_many :reports }
  it { should have_many(:students).through(:reports) }

  it { should validate_presence_of(:title).with_message(/[a-z\.]+/) }
  it { should validate_presence_of(:language) }

  it "save information from xml to homework table" do
    xml_file = File.expand_path("spec/models/julia.tymo_creational.patterns-result.xml")
    xml_data = Report.send( :xml_file_to_hash, xml_file)
    xml_data.class.should == Hash

    h = FactoryGirl.create(:homework,
      title: xml_data[:homework],
      language: xml_data[:language])
    h.title.should == "creational.patterns"
    h.language.should == "ruby"
  end
end







