require "./file_manager.rb"
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
	FileManager::Copier.new(student, homework).tmp_to_homework
end


puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
puts "FINISH"
puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

#Unarchive::P7z.new('pagination.7z').extract
#Unarchive::PZip.new('Downloads.zip').extract
