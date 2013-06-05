class Report < ActiveRecord::Base
  WORK_PATH = File.expand_path('app/received')
  ARCHIVE_PASSED = ' have successfully processed'
  ARCHIVE_FAILED = ' have failed. Something went wrong' 

  attr_accessible :homework_id, :quality, :ratio, :student_id, :time
  belongs_to :student
  belongs_to :homework

  validates_presence_of :quality, :ratio, :time

  validates_numericality_of :quality, :ratio, {
    greater_than_or_equal_to: 0.00,
    less_than_or_equal_to: 100.00
  }
  validates_numericality_of :time, greater_than: 0.00


  def self.home_work_check
    HomeWorkChecker::FileScan.new(WORK_PATH, '/tmp').each do |name, type|
      Resque.enqueue(ArchiveChecker, WORK_PATH, '/tmp', name, type)
    end
  end

  def self.archive_passed(archive_name)
    "Archive '#{archive_name}'#{ARCHIVE_PASSED}"
  end

  def self.archive_failed(archive_name)
    "Archive '#{archive_name}'#{ARCHIVE_FAILED}"
  end

  def self.add_record(fn)
    xml_content = xml_file_to_hash(fn)
    s = Student.where(name: xml_content[:student]).first_or_create
    h = Homework.where(
      title: xml_content[:homework],
      language: xml_content[:language]
    ).first_or_create

    s.reports.create(
      homework_id: h.id,
      ratio: xml_content[:ratio],
      quality: xml_content[:quality],
      time: xml_content[:time]
    ).valid?
  end

  private
  def self.xml_file_to_hash(fn)
    Nokogiri::XML(File.open(fn, 'r')).xpath('//root').map do |f|
      {
        student: f.xpath('student').inner_text,
        homework: f.xpath('homework').inner_text,
        language: f.xpath('language').inner_text,
        ratio: f.xpath('ratio').inner_text.to_f,
        quality: f.xpath('quality').inner_text.to_f,
        time: f.xpath('time').inner_text.to_f
      }
    end.first
  end
end
