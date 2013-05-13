require_relative "./unarchive.rb"


module Unarchive
  #
  # extract 7z archives into DESTIN_PATH directory
  #
  class SevenZip
    def initialize(filename, student)
      @filename, @student = filename, student
    end


    def extract
      `7z x #{WORK_PATH}/#{@filename} -o#{TMP_PATH}/#{@student}`
    end 
  end
end