class Scaner
  
  attr_reader :archive_all 
  def initialize folder
    @archive_all = []
    @folder = folder
  end

  def scan
    @archive_all.clear

    Dir::foreach(@folder) do |p|
      if File::file?("#{@folder}/#{p}") && ['.zip','.7z'].include?(File::extname p)  #&& !self.exist?(p.dup)
        @archive_all << p
      end
    end

    @archive_all
  end
end