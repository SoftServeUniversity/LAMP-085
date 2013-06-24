class DBBackup
  @queue = :db_backup

  def self.perform(user)
    %x|rake db:backup|
    BackupNotifier.backup_email(user).deliver
  end
end
