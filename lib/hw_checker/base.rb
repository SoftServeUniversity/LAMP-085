module HomeWorkChecker
  class Base
    def self.start(work_path, tmp_path, name, type)
      `rm -r #{tmp_path}/#{name}` if Dir.exist?("#{tmp_path}/#{name}")
      time_start, xml_content = Time.now, {} 
      Unarchive::Zip.new("#{work_path}/#{name+type}", tmp_path)
      stat = TestRunStat::execute(work_path, tmp_path, name)

      xml_content = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
        xml.root {
          xml.student name.split('_').first
          xml.homework name.split('_').last
          xml.ratio stat.first
          xml.quality stat.last
          xml.time (Time.now - time_start).round(2) 
        }
      end.to_xml

      File.open("#{work_path}/#{name}-result.xml", 'w') do |file| 
        file.write xml_content
      end
    end  
  end
end