#rake resque:work QUEUE='*'
class UnarchiveProcesor
  @queue = :unarchive_procesor

  def self.perform(path,name,type)
  	HwCheker.check_new(path, name, type)
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
  end
end
# path = File.expand_path "app/resived"
#   HwCheker.scan_only( path).each do |name, type|
#       Resque.enqueue(UnarchiveProcesor, HwCheker.check_new( path, name, type))