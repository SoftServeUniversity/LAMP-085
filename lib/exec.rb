require "./file_manager.rb"
require "./scan_dir.rb"
require "./standard_zip.rb"
require "./seven_zip.rb"
require "fileutils"
#require 'active_support/inflector'

Unarchive::ScanDir.new.get_archives.each do |f|
	homework = f.slice(/.*:/).slice(0..-2)
	student = f.slice(/:.*\./).slice(1..-2)
	FileUtils::mkdir_p("#{Unarchive::TMP_PATH}/#{student}")

=begin	
  class_name = Unarchive::ARCHIVE_TYPES[
	File::extname(f)].constantize
	class_name.new(f, student).extract
=end
  class_name = Unarchive::ARCHIVE_TYPES[File::extname(f)].split('::')
  Object.const_get(class_name[0]).const_get(class_name[1]).new(f, student).extract

  FileManager::Copier.new(student, homework).tmp_to_homework
end


puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
puts "FINISH"
puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

#Unarchive::P7z.new('pagination.7z').extract
#Unarchive::PZip.new('Downloads.zip').extract