require 'rubygems'
require 'zip/zip'
class ZipUnarchive
		
	def unzip_file (file, destination)
			  Zip::ZipFile.open(file) { |zip_file| 
	  		zip_file.each { |f|
			     f_path=File.join(destination, f.name)
			     zip_file.extract(f, f_path) unless File.exist?(f_path)
	      }
	  }
	end
end

p = ZipUnarchive.new
p.unzip_file("/home/user/work/zipfile.zip", "/home/user/work/unzip")
