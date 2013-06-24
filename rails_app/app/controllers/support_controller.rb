class SupportController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def restore
    flash[:info] = 'Restoring database was added to queue'
    redirect_to root_path
  end

  def back_up
    flash[:info] = 'Backing up database was added to queue'
    redirect_to root_path
  end

  def destroy
    [Student, Homework, Report].each do |model|
      model.delete_all
    end
    flash[:success] = 'Students and homeworks was successfully deleted'
    redirect_to root_path
  end
end
