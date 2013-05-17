module HomeWorkChecker
  module Unarchive
    class Zip < Base
      def initialize(work_path, tmp_path, filename)
        @work_path, @tmp_path, @filename = work_path, tmp_path, filename
      end
    end
  end
end 