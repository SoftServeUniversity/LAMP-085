class LoggerController < ApplicationController
  before_filter :authenticate_user!

  def index
    @years = Report.find_files_to_download.first
    @months = Report.find_files_to_download.last.map do |num|
      Report::MONTHS_LIST[num]
    end
  end

  def load
    current_year = Time.now.to_s[0..3]
    selected_month = Report::MONTHS_LIST.key(params[:month])
    if params[:year] == current_year && selected_month
      path = "#{Report::LOG_PATH}/home_work_check_#{params[:year]}-#{selected_month}.log" 
      send_file path, :type => 'text/plain'
    elsif params[:year] =~ /^\d{4}$/ && params[:year] != current_year
      path = "#{Report::LOG_PATH}/home_work_check_#{params[:year]}.7z"
      send_file path, :type => 'application/x-7z-compressed' 
    else
      flash[:error] = 'You are choosen file does not exist.'
      redirect_to logger_path
    end
  end
end
