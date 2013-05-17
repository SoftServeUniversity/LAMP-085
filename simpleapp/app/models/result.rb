require 'terminator'

class Result < ActiveRecord::Base
  attr_accessible :name, :points, :task

  def exec
    @q = Terminator.new
    @q.create
     # @q.cmds_queue.execute
    @q.cmds_queue.commands.each do |do_in_back|
      Resque.enqueue( UnarchiveWorker, do_in_back)
    end
  end
end
