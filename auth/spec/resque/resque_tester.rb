class Checker
  @queue = :archives

  attr_reader :time
  
  def into_queue
    @time = Time.now
    Resque.enqueue(Checker, @time, :into_queue)
  end
end