# Logging related work
namespace :log do
  desc "Remove all log files"
  task :clear do
    system 'rm -vf tmp/*.log tmp/*.output log/*.log*'
  end
  
  desc "Print all error messages in the log files"
  task :errors => :environment do
    season_log = "log/#{@genesis.config.global :season}.log"
    system_log = 'tmp/autumn.log'
    if File.exists? season_log then
      puts "==== ERROR-LEVEL LOG MESSAGES ===="
      File.open(season_log, 'r') do |log|
        puts log.grep(/^[EF],/)
      end
    end
    if File.exists? system_log then
      puts "====   UNCAUGHT EXCEPTIONS    ===="
      File.open(system_log, 'r') do |log|
        puts log.grep(/^[EF],/)
      end
    end
  end
end


