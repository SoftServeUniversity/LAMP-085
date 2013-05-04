require "./unarchive.rb"


module Unarchive
  #
  # extract 7z archives into DESTIN_PATH directory
  #
  class P7z
    def initialize(filename)
      @filename = filename
    end

    def extract

      `7z x #{WORK_PATH}/#{@filename} -o#{TMP_PATH}/#{@student}`
    end 
  end
end

