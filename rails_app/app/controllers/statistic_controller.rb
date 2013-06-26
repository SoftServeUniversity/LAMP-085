class StatisticController < ApplicationController
  before_filter :authenticate_user!
  
  def language
    @language, @data = [], []
    Homework.all.each do |l|
      unless @language.include?l.language
        @language << l.language 
      end
    end
    @data << ["Language Type", "Count"]
    @language.each do |lan|      
      @data << [lan, Homework.where(:language => lan).count(:language)]
    end    
  end

  def time
    @date = []
    @ratio, @quality, @time = [], [], []
    Report.all.each do |r|
      @ratio << r.ratio
      @quality << r.quality
      @time << r.time
      @date << [
        r.updated_at.year,
        r.updated_at.mon-1, 
        r.updated_at.day, 
        r.updated_at.hour, 
        r.updated_at.min, 
        r.updated_at.sec]
    end
  end
end
