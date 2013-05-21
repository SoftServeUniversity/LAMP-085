module HomeWorkChecker
  module TestRun
    class PythonTestRun < TestBase
      def initialize(path)
        super
      end

      def perform
        system `cd "#{@path}/test"`
        system `nosetests` 
      end
    end
  end
end 