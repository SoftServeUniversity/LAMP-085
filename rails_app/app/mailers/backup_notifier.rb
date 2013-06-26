class BackupNotifier < ActionMailer::Base
    default :from => "mihvaren@gmail.com"
  
    def backup_email(user)
      @user = user
      mail :to => @user['email'], :subject => "Backup was createds"  
    end

    def restore_email(user)
      @user = user
      mail :to => @user['email'], :subject => "Databse was restored succesfuly"  
    end
end