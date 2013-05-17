require 'command'
class LogDb < Command

  def initialize student, homework
    super "saving some data about #{student} results to database"
    @user = student
    @task = homework
  end

  def execute
    @result = Result.new

    @result.name = @user
    @result.task = @task
    @result.points = 1

    unless @result.save
      raise "Can't save to database."
    end
  end
end