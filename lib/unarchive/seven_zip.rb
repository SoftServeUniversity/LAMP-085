module HomeWorkChecker
  module Unarchive
    class SevenZip < Zip
      def initialize(work_path, tmp_path, filename)
        super
      end

      def extract
        `7z x #{@work_path}/#{@filename} -o#{@tmp_path}`
      end
    end
  end
end 