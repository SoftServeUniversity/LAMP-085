module HomeWorkChecker
  module TestRun
    class PythonTestRun
      def initialize(path)
        `cd #{path}/test`
        puts `nosetests`
      end
    end
  end
end
