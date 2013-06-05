#rake resque:work QUEUE='*'
class UnarchiveProcesor
  ARCHIVE_PASSED = ' have successfully processed'
  ARCHIVE_FAILED = ' have failsed. Something went wrong'
  @queue = :unarchive_procesor

  def self.perform(work_path, tmp_path, name, type)
    HomeWorkChecker::Base.start(work_path, tmp_path, name, type)
=begin
  	path1 = File.expand_path "app/resived/#{name}-result.xml"
    f = File.open(path1)
    doc = Nokogiri::XML(f)
    @links = doc.xpath('//root').map do |i|
      {'student' => i.xpath('student').inner_text,'homework' => i.xpath('homework').inner_text,'ratio' => i.xpath('ratio').inner_text,'quality' => i.xpath('quality').inner_text,'time' => i.xpath('time').inner_text}.to_a
    end
    student = Student.find_or_create_by_name("#{@links[0][0][1]}")
    
    homework = Homework.find_or_create_by_title(
      title: "#{@links[0][1][1]}",
      description: "su",
      language: "ruby")

    Report.create(
      student_id: student.id,
      homework_id: homework.id,
      ratio: @links[0][2][1],
      quality: @links[0][3][1],
      time: @links[0][4][1])

    f.close
=end
  end

  private
  def self.archive_passed(archive_name)
    "Archive '#{archive_name}'#{ARCHIVE_PASSED}"
  end

  def self.archive_failed(archive_name)
    "Archive '#{archive_name}'#{ARCHIVE_FAILED}"
  end

  def self.xml_file_to_hash(fn)
    # ...
  end

  def self.add_record(fn)
    # ...
  end
end
# path = File.expand_path "app/resived"
#   HwCheker.scan_only( path).each do |name, type|
#       Resque.enqueue(UnarchiveProcesor, HwCheker.check_new( path, name, type))
