class Report < ActiveRecord::Base
  ARCHIVE_PATH = File.expand_path('~/Desktop/hwc_archives')
  RESULT_PATH = File.expand_path('~/Desktop/hwc_results')
  LOG_PATH = File.expand_path('log')
  ARCHIVE_PASSED = ' have successfully processed'
  ARCHIVE_FAILED = ' have failed. Something went wrong'
  MONTHS_LIST = {
    '01' => 'January',
    '02' => 'February',
    '03' => 'March',
    '04' => 'April',
    '05' => 'May',
    '06' => 'June',
    '07' => 'Jule',
    '08' => 'August',
    '09' => 'September',
    '10' => 'October',
    '11' => 'November',
    '12' => 'December'
  } 

  attr_accessible :homework_id, :quality, :ratio, :student_id, :time
  belongs_to :student
  belongs_to :homework

  validates_presence_of :quality, :ratio, :time

  validates_numericality_of :quality, :ratio, {
    greater_than_or_equal_to: 0.00,
    less_than_or_equal_to: 100.00
  }
  validates_numericality_of :time, greater_than: 0.00


  def self.homework_check
    begin
      HomeWorkChecker::FileScan.new(ARCHIVE_PATH, RESULT_PATH).each do |name, type|
        Resque.enqueue(ArchiveChecker, ARCHIVE_PATH, RESULT_PATH, name, type)
      end
    rescue HomeWorkChecker::DirectoryExistError, HomeWorkChecker::DirectoryFormatError, RuntimeError => error
      logger = OwnLogger::HomeWorkChecker.new(LOG_PATH)
      logger.add_line(error.message)
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
    s = Student.where(
      name: xml_content[:student]
    ).first_or_create
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

  def self.find_files_to_download
    logger = OwnLogger::HomeWorkChecker.new(LOG_PATH)
    logger.find_files_to_download
  end

  def self.compress_log_files
    year_prev = Time.now.to_s[0..3].to_i
    logger = OwnLogger::HomeWorkChecker.new(LOG_PATH)
    logger.compress_files(year_prev)
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
