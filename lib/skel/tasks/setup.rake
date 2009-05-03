desc 'install all possible dependencies'
task :setup => :gem_installer do
  GemInstaller.new do
    # core
    gem 'facets'
    gem 'anise'
    gem 'english', '> 0', :lib => "english/style"
    gem 'daemons'

    # spec
    gem 'rspec', '> 1', :lib => "spec"

    # database
    gem 'dm-core'
    gem 'do_sqlite3'

    setup
  end
end
