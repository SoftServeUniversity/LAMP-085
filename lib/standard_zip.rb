require_relative "./unarchive.rb"


module Unarchive
  #
  # extract zip archives into TMP_PATH directory
  #
  class StandardZip
    def initialize(filename, student)
      @filename, @student = filename, student
    end
    

    def extract
      `unzip #{WORK_PATH}/#{@filename} -d #{TMP_PATH}/#{@student}`
    end 
  end
end
