class UnarchiveWorker
  @queue = :unpack_queue
  def self.perform(command)
    command
  end
end