require 'command'
class Runtest < Command

  def initialize homework, tmp_path, destin_path, student
    super "executing tests in #{tmp_path}/#{student} and save it in #{destin_path}"
    @current_path = "#{tmp_path}/#{student}"
    @user = student
    @dest = destin_path 
    @home = homework
    @tmp = tmp_path
  end

  def execute
    
    unless Dir::entries(@current_path).include?("test")
      raise "Student #{@user} didn't put TEST folder"
    end 

    if Dir::entries(@current_path).map!{|i| File::extname(i)}.include?(".rb")
      @folder = "ruby"
    elsif Dir::entries(@current_path).map!{|i| File::extname(i)}.include?(".slc")
    @folder = "scala"
    else 
      raise "Directory #{@user} hasn't ruby or scala files "
    end

    if Dir::entries("#{@dest}/#{@folder}").include?("#{@home}")
      FileUtils::cp_r("#{@current_path}","#{@dest}/#{@folder}/#{@home}") 
    else
      FileUtils::mkdir_p("#{@dest}/#{@folder}/#{@home}")
      FileUtils::cp_r("#{@current_path}","#{@dest}/#{@folder}/#{@home}") 
    end
    
    FileUtils::rm_rf("#{@tmp}/.")    
    if @folder == "ruby"
      system "rspec #{@dest}/ruby/#{@homework}/#{@user}/test/spec.rb" 
    end
    return @folder
  end
end