module HomeWorkChecker
  class Base
    def self.start(archive_path, result_path, name, type, tmp_path = '/tmp')
      `rm -r #{tmp_path}/#{name}` if Dir.exist?("#{tmp_path}/#{name}")
      time_start, xml_content = Time.now, {} 
      Unarchive::Zip.new("#{archive_path}/#{name+type}", tmp_path)   
      stats = ArchiveResult.execute(tmp_path, name)
      stats << (Time.now - time_start).round(2)

      File.open("#{result_path}/#{name}.xml", 'w') do |file| 
        file.write(generate_xml_content(name, stats) )
      end
    end 

    private
    def self.generate_xml_content(identity, info)
      Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
        xml.root {
          xml.student identity.split('_').first       # student name
          xml.homework identity.split('_').last       # homework
          xml.language info[0]                        # language
          xml.ratio info[1]                           # ratio of passed and failed tests
          xml.quality info[2]                         # code quality
          xml.time info[3]                            # time of executing
        }
      end.to_xml
    end
  end
end
