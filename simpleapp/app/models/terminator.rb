require 'logdb'
require 'runtest'
require 'scaner'
require 'unarchive'
require 'command'
require 'composite_command'

class Terminator

  attr_reader :cmds_queue
  
  def initialize
    @work_path = File.expand_path "app/reseived"
    @dest_path = File.expand_path "app/homework"
    @tmp_path = File.expand_path "app/temporary"
  end

  def create
    @cmds_queue = CompositeCommand.new
    @scaner = Scaner.new(@work_path)
    @scaner.scan
    @scaner.archive_all.each do |todo|
      @homework = todo.slice(/.*:/).slice(0..-2)
      @student = todo.slice(/:.*\./).slice(1..-2)
      @unarchiv = Unarchive.new(todo, @work_path, @tmp_path, @student)
      @cmds_queue.add(@unarchiv.execute) 
      @run = Runtest.new(@homework, @tmp_path, @dest_path, @student)
      @cmds_queue.add(@run.execute)
      @log = LogDb.new(@student, @homework)
      @cmds_queue.add(@log.execute)
    end

    @cmds_queue
  end
end