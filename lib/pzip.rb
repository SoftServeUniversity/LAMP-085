require "./unarchive.rb"


module Unarchive
  #
  # extract zip archives into TMP_PATH directory
  #
  class PZip
    def initialize(filename,student)
      @filename = filename
      @student= student

    end

    def extract
      `unzip #{WORK_PATH}/#{@filename} -d #{TMP_PATH}/#{@student}`
    end 
  end
end
