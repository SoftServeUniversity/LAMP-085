class StatisticController < ApplicationController
  before_filter :authenticate_user!
  
  def language
    # @language, @data = [], []
    # Homework.all.each do |l|
    #   unless @language.include?l.language
    #     @language << l.language 
    #   end
    # end
    # @data << ["Language Type", "Count"]
    # @language.each do |lan|      
    #   @data << [lan, Homework.where(:language => lan).count(:language)]
    # end    
    @reports_rb = Homework.where(:language => 'ruby').count(:language)
    @reports_py = Homework.where(:language => 'python').count(:language)
  end

  def time
    @ratio = []
    @quality = []
    @time = []
    @ratio, @quality, @time, @date_ye, @date_mo, @date_da, @date_ho, @date_mi, @date_se = [], [], [], [], [], [], [], [], []
    Report.all.each do |r|
      @ratio << r.ratio
      @quality << r.quality
      @time << r.time
      @date_ye << r.updated_at.year
      @date_mo << r.updated_at.mon-1
      @date_da << r.updated_at.day
      @date_ho << r.updated_at.hour
      @date_mi << r.updated_at.min
      @date_se << r.updated_at.sec
    end
  end
end
