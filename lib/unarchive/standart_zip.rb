module HomeWorkChecker
  module Unarchive
    class StandartZip < Zip
      def initialize(work_path, tmp_path, filename)
        super
      end

      def extract
        `unzip #{@work_path}/#{@filename} -d #{@tmp_path}`
      end
    end
  end
end 