class SupportController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def select
    base_path = Rails.root
    base_path = File.join(base_path, ENV["DIR"] || "backups")
    backup_base = File.join(base_path, 'db_backups')
    dir = Dir.new(backup_base)
    @file_name = dir.entries
  end

  def restore
    flash[:info] = 'Database was successfully restored'
    @file_name = params[:select_file]
    %x|FILE="#{@file_name}" rake db:restore|
    BackupNotifier.restore_email(current_user).deliver
    redirect_to root_path
  end

  def back_up
    flash[:info] = 'Backing up database was added to queue'
    Resque.enqueue(DBBackup,current_user)
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
