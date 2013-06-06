class LogController < ApplicationController
  def show
    @logs = File.new( (File.expand_path("app/resived/hw_cheker.log")), "r")
  end
end
