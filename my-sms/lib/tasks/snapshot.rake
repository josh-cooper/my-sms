require 'fileutils'

# from https://gist.github.com/stevebartholomew/50180/749a222426d440f1b6feb70c9575a750fa08b0a9

namespace :db do
  desc "Backup MySQL database using mysqldump."
  task snapshot: :environment do
    settings = Rails.configuration.database_configuration[Rails.env]
    output_file = Rails.root.join('backups', "#{settings['database']}-#{Time.now.strftime('%Y%m%d-%H:%M')}.sql")
    FileUtils.mkdir_p Rails.root.join('backups')

    system("mysqldump -h #{settings['host']} -u #{settings['username']} -p#{settings['password']} #{settings['database']} > #{output_file}")
  end

  namespace :snapshot do
    desc "Load dumped MySQL database."
    task :load, [:timestamp] => [:environment] do |task, args|
      settings = Rails.configuration.database_configuration[Rails.env]
      output_file = Rails.root.join('backups', "#{settings['database']}-#{args.timestamp}.sql")

      system("mysql -h #{settings['host']} -u #{settings['username']} -p#{settings['password']} #{settings['database']} < #{output_file}")
    end
  end
end
