# Document generation
namespace :doc do
  desc "Generate documentation for all leaves"
  task :leaves => :environment do
    FileUtils.remove_dir 'doc/leaves' if File.directory? 'doc/leaves'
    Dir.glob("leaves/*").each do |leaf_dir|
      Dir.chdir leaf_dir do
        system "rdoc --main README --title '#{File.basename(leaf_dir).camelcase} Documentation' -o ../../doc/leaves/#{File.basename leaf_dir} --line-numbers --inline-source controller.rb helpers models README"
      end
    end
  end
  
  desc "Remove all documentation"
  task :clear => :environment do
    FileUtils.remove_dir 'doc/leaves' if File.directory? 'doc/leaves'
  end
end


