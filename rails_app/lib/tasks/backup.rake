require 'fileutils'

namespace :db do  desc "Backup project database. Options: DIR=backups Rails.env=production MAX=4" 
  task :backup => [:environment] do
    MAX_NUM = 4
    datestamp = Time.now.strftime("%Y-%m-%d_%H-%M-%S")    
    base_path = Rails.root
    base_path = File.join(base_path, ENV["DIR"] || "backups")
    backup_base = File.join(base_path, 'db_backups')
    backup_folder = File.join(backup_base, datestamp)
    backup_file = File.join(backup_folder, "#{Rails.env}_dump.sql")    
    FileUtils.mkdir_p(backup_folder)  

    db_config = ActiveRecord::Base.configurations[Rails.env]    
    `mysqldump -u #{db_config['username']} -i -c -q #{db_config['database']} > #{backup_file}`
    raise "Unable to make DB backup!" if ( $?.to_i > 0 )
    `gzip -9 #{backup_file}`

    dir = Dir.new(backup_base)
    all_backups = dir.entries.sort[2..-1].reverse
    puts "Created backup: #{backup_file}"     
    max_backups = (ENV["MAX"].to_i if ENV["MAX"].to_i > 0) || MAX_NUM
    unwanted_backups = all_backups[max_backups..-1] || []
      for unwanted_backup in unwanted_backups
        FileUtils.rm_rf(File.join(backup_base, unwanted_backup))
      end
    puts "Deleted #{unwanted_backups.length} backups, #{all_backups.length - unwanted_backups.length} backups available" 
  end

end