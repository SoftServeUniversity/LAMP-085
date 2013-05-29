#rake resque:work QUEUE='*'
class UnarchiveProcesor
  @queue = :unarchive_procesor

  def self.perform comand
    comand 
  end
end
# path = File.expand_path "app/resived"
#   HwCheker.scan_only( path).each do |name, type|
#       Resque.enqueue(UnarchiveProcesor, HwCheker.check_new( path, name, type))