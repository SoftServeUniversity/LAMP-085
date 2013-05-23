module HomeWorkChecker
  module Unarchive
    class Zip

      def initialize(filename, tmp_path = '/tmp')
        @file = filename
        `7za t #{@file}`
        `7z x #{@file} -o#{tmp_path}`
      end
    end
  end
end