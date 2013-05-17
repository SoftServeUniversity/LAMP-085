require 'command'


class CompositeCommand < Command

  attr_reader :commands

  def initialize
    @commands = []
  end

  def add command
    @commands << command
  end

  def execute
    @commands.each do |cmd|
      cmd.execute
    end
  end

  def description
    description = ''
    @commands.each do |cmd|
      description += cmd.description + "\n"
    end
    description
  end
end