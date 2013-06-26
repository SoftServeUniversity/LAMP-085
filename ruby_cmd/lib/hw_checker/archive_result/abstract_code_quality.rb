module HomeWorkChecker
  module ArchiveResult
    class AbstractCodeQuality
      def perform
        raise RuntimeError, 'Should be redefined in hereditary classes'
      end
    end
  end
end
