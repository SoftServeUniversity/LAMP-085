require "./unarchive.rb"


module Unarchive
  #
  # extract zip archives into DESTIN_PATH directory
  #
  class PZip
    def initialize(filename)
      @filename = filename
    end

    def extract
      `unzip #{WORK_PATH}/#{@filename} -d #{DESTIN_PATH}`
    end 
  end
end
