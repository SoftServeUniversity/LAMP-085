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
        @file_scan.instance_variable_get(:@files).should have(7).items 
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
          ["julia.tymo_creational.patterns", ".7z"],
          ["julia.tymo_iterators.in.ruby", ".zip"],
          ["pavlo.petryk_creational.patterns", ".zip"],
          ["pavlo.petryk_final.tasks", ".7z"],
          ["roman.horobets_creational.patterns", ".7z"],
          ["roman.horobets_final.tasks", ".zip"],
          ["roman.horobets_iterators.in.ruby", ".zip"]
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
