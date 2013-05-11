require "./unarchive.rb"

module FileManager

	class Copier

		def initialize (student, homework)
			@student = student
			@homework = homework			
			@current_path = "#{Unarchive::TMP_PATH}/#{@student}"
			unless Dir::entries(@current_path).include?("test")
				raise "Student #{@student} didn't put TEST folder"
			end 
		end

		def tmp_to_homework
			if Dir::entries(@current_path).map!{|i| File::extname(i)}.include?(".rb")
				@folder = "ruby"
			elsif Dir::entries(@current_path).map!{|i| File::extname(i)}.include?(".slc")
				@folder = "scala"
			else 
				raise "Directory #{@student} hasn't ruby or scala files "
			end
			if Dir::entries("#{Unarchive::DESTIN_PATH}/#{@folder}").include?("#{@homework}")
				FileUtils::cp_r("#{@current_path}","#{Unarchive::DESTIN_PATH}/#{@folder}/#{@homework}")	
			else
				FileUtils::mkdir_p("#{Unarchive::DESTIN_PATH}/#{@folder}/#{@homework}")
				FileUtils::cp_r("#{@current_path}","#{Unarchive::DESTIN_PATH}/#{@folder}/#{@homework}")	
			end
			FileUtils::rm_rf("#{Unarchive::TMP_PATH}/.")		
			if @folder == "ruby"
				system "rspec #{Unarchive::DESTIN_PATH}/ruby/#{@homework}/#{@student}/test/spec.rb"	
			end
			return @folder
		end
		
	end
end