def local_db?(db)
  db.host.nil? or db.host == 'localhost'
end

namespace :db do
  desc "Recreate database tables according to the model objects"
  task :migrate => :boot do
    dname = ENV['DB']
    raise "Usage: DB=[Database config name] rake db:migrate" unless dname
    raise "Unknown database config #{dname}" unless database = repository(dname.to_sym)
    puts "Migrating the #{dname} database..."
    # Find models that have definitions for the selected database and migrate them
    repository(dname.to_sym) do
      repository(dname.to_sym).models.each { |mod| mod.auto_migrate! dname.to_sym }
    end
  end
  desc "Nondestructively update database tables according to the model objects"
  task :upgrade => :boot do
    dname = ENV['DB']
    raise "Usage: DB=[Database config name] rake db:upgrade" unless dname
    raise "Unknown database config #{dname}" unless database = repository(dname.to_sym)
    puts "Upgrading the #{dname} database..."
    # Find models that have definitions for the selected database and upgrade them
    repository(dname.to_sym) do
      repository(dname.to_sym).models.each { |mod| mod.auto_upgrade! dname.to_sym }
    end
  end
end


