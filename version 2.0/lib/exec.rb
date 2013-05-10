require 'active_support/inflector'
require "./scan_dir.rb"
require "./pzip.rb"
require "./p7z.rb"


Unarchive::ScanDir.new.get_archives.each do |f|
  class_name = Unarchive::ARCHIVE_TYPES[File::extname(f)].constantize
  class_name.new("#{f}").extract
end


#Unarchive::P7z.new('pagination.7z').extract
#Unarchive::PZip.new('Downloads.zip').extract
