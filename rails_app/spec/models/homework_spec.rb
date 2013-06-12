require 'spec_helper'

describe Homework do
    before (:each) do
    xml_file = File.expand_path("julia.tymo_creational.patterns-result.xml")
    @xml_data = Report.send( :xml_file_to_hash, xml_file) 
    end
  it { should have_many :reports }
  it { should have_many(:students).through(:reports) }

  it { should validate_presence_of(:title).with_message(/[a-z\.]+/) }
  it { should validate_presence_of(:language) }

  it "save information from xml to homework table" do
    @xml_data.class.should == Hash

    h = FactoryGirl.create(:homework,
      title: @xml_data[:homework],
      language: @xml_data[:language])
    h.title.should == "creational.patterns"
    h.language.should == "ruby"
  end

  it "has data in XML file" do
    @xml_data.should include( :student=>"julia.tymo", :homework=>"creational.patterns", :language=>"ruby", :ratio=>0.0, :quality=>28.57, :time=>1.3)
  end

  it "has 6 items" do
    @xml_data.should have(6).items
  end
end







