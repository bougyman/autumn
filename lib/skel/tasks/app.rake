# Application control
namespace :app do
  desc "Launch the Autumn daemon"
  task :start do
    system 'autumn start -D'
  end
  
  desc "Stop the Autumn daemon"
  task :stop do
    system 'autumn stop'
  end
  
  desc "Restart the Autumn daemon"
  task :restart do
    system 'autumn restart -D'
  end
  
  desc "Start Autumn but not as a daemon (stay on top)"
  task :run do
    system 'autumn start'
  end
  
  desc "Force the daemon to a stopped state (clears PID files)"
  task :zap do
    system 'autumn stop'
  end
end


