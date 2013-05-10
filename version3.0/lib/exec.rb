require "./scan_dir.rb"
require "./pzip.rb"
require "./p7z.rb"
require "fileutils"
require 'active_support/inflector'

Unarchive::ScanDir.new.get_archives.each do |f|
	homework = f.slice(/.*:/).slice(0..-2)
	student = f.slice(/:.*\./).slice(1..-2)
	FileUtils::mkdir_p("#{Unarchive::TMP_PATH}/#{student}")
	class_name = Unarchive::ARCHIVE_TYPES[
	File::extname(f)].constantize
	class_name.new(f, student).extract
	current_path = "#{Unarchive::TMP_PATH}/#{student}"
  
	if Dir::entries(current_path).include?("test") 
		if Dir::entries(current_path).map!{|i| File::extname(i)}.include?(".rb")
			if Dir::entries("#{Unarchive::DESTIN_PATH}/ruby").include?("#{homework}")
				FileUtils::cp_r("#{current_path}","#{Unarchive::DESTIN_PATH}/ruby/#{homework}")	
			else
				FileUtils::mkdir_p("#{Unarchive::DESTIN_PATH}/ruby/#{homework}")
				FileUtils::cp_r("#{current_path}","#{Unarchive::DESTIN_PATH}/ruby/#{homework}")	
			end
		end

		if Dir::entries(current_path).map!{|i| File::extname(i)}.include?(".slc")
			if Dir::entries("#{Unarchive::DESTIN_PATH}/scala").include?("#{homework}")
				FileUtils::cp_r("#{current_path}","#{Unarchive::DESTIN_PATH}/scala/#{homework}")	
			else
				FileUtils::mkdir_p("#{Unarchive::DESTIN_PATH}/scala/#{homework}")
				FileUtils::cp_r("#{current_path}","#{Unarchive::DESTIN_PATH}/scala/#{homework}")	
			end
		end 
		system "rspec #{Unarchive::DESTIN_PATH}/ruby/#{homework}/#{student}/test/spec.rb"	
	end
end
FileUtils::rm_rf("#{Unarchive::TMP_PATH}/.")


puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
puts "FINISH"
puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

#Unarchive::P7z.new('pagination.7z').extract
#Unarchive::PZip.new('Downloads.zip').extract
