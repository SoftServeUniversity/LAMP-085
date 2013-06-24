namespace :db do  desc "Restore database grom dump" 
  task :restore => [:environment] do 
    file = ENV["FILE"]
    base_path = Rails.root
    base_path = File.join(base_path, ENV["DIR"] || "backups")
    backup_base = File.join(base_path, 'db_backups')
    backup_archeive = File.join(backup_base, file)
    rest_folder = File.join(backup_archeive, "#{Rails.env}_dump.sql.gz")
    rest_dump = File.join(backup_archeive, "#{Rails.env}_dump.sql")
    `gunzip #{rest_folder}`
    db_config = ActiveRecord::Base.configurations[Rails.env]
    `mysql -u #{db_config['username']} #{db_config['database']} < #{rest_dump}`
     raise "Unable to make DB restore!" if ( $?.to_i > 0 )
    `gzip -9 #{rest_dump}`
  end
end