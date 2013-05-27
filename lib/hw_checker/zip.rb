module HomeWorkChecker
  module Unarchive
    class Zip
      def initialize(filename, tmp_path = '/tmp')
        `7za t #{filename}`
        `7z x #{filename} -o#{tmp_path}`
      end
    end
  end
end