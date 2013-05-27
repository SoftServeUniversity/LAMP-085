module HomeWorkChecker
  module TestRunStat
    class PythonTestRun
      def initialize(path)
        `cd #{path}/test`
        puts `nosetests`
      end
    end
  end
end
