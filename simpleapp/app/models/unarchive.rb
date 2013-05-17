require 'fileutils'
require 'command'
class Unarchive < Command

  def initialize to_unpack_file, work_path, tmp_path, student
    super "unarchive file #{to_unpack_file} from #{work_path} into #{tmp_path}/#{student}"
    @file = to_unpack_file
    @work = work_path
    @tmp = tmp_path
    @user = student
  end

  def execute
    type = File.extname @file
    FileUtils.mkdir "#{@tmp}/#{@user}"
    case type
    when ".7z"
      `7z x #{@work}/#{@file} -o #{@tmp}/#{@user}`
    when ".zip"
      `unzip #{@work}/#{@file} -d #{@tmp}/#{@user}`
    end
  end
end