require_relative '../lib/hw_checker'

module HomeWorkChecker
  describe FileScan do
    before(:each) do
      @file_scan = FileScan.new('./support')
    end

    context '.new' do
      def is_all_archives?
        @file_scan.instance_variable_get(:@files).each do |item; ext_name|
          ext_name = File::extname(item)
          return false unless FILE_TYPES.include?(ext_name)
        end
        true
      end
      it 'should have exactly 6 items' do
        @file_scan.instance_variable_get(:@files).should have(6).items 
      end
      it 'should contain .zip/7z files only' do
        is_all_archives?.should_not be_false
      end
    end

    context '#each' do
      before(:each) do
        @file_scan.instance_variable_get(:@files).sort!
      end
      it 'should yield correct data' do
        expect { |b| @file_scan.each(&b) }.to yield_successive_args(
          ["homework-500:ivanov", ".7z"],
          ["homework-500:petrov", ".zip"],
          ["homework-500:sidorov", ".zip"],
          ["homework-700:petrov", ".zip"],
          ["homework-700:sidorov", ".zip"],
          ["homework-900:tarasov", ".7z"]
        )
      end
    end

    context '#exist_xml?' do
      it 'xml-file should exist' do
        @file_scan.should_not be_exist_xml('test.xml')
      end
    end  
  end
end
