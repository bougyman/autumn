begin; require 'rubygems'; rescue LoadError; end

require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'time'
require 'date'

PROJECT_SPECS = FileList[
  'spec/*.rb',
  'lib/skel/spec/*.rb'
]

PROJECT_MODULE = 'Autumn'
PROJECT_README = 'README.markdown'
#PROJECT_RUBYFORGE_GROUP_ID = 3034
PROJECT_COPYRIGHT = [
  "#          Copyright (c) #{Time.now.year} Tim Morgan riscfuture@gmail.com",
  "# Distributed under the same terms as the Ruby license.",
  "# Portions of this code are copyright ©2004 David Heinemeier Hansson; ",
  "# please see libs/inheritable_attributes.rb for more information.",
  "# Autumn's package tasks are copyright 2009 Michael Fellinger m.fellinger@gmail.com;",
  "# Distributed under the terms of the Ramaze license"
]

# To release the monthly version do:
# $ PROJECT_VERSION=2009.03 rake release
IGNORE_FILES = [/\.gitignore/]

GEMSPEC = Gem::Specification.new{|s|
  s.name         = 'autumn'
  s.author       = "Tim 'riscfuture' Morgan"
  s.summary      = "Autumn is a simple and modular irc framework"
  s.description  = s.summary
  s.email        = 'bougy.man@gmail.com'
  s.homepage     = 'http://github.com/bougyman/autumn'
  s.platform     = Gem::Platform::RUBY
  s.version      = (ENV['PROJECT_VERSION'] || Date.today.strftime("%Y.%m.%d"))
  s.files        = `git ls-files`.split("\n").sort.reject { |f| IGNORE_FILES.detect { |exp| f.match(exp)  } }
  s.has_rdoc     = true
  s.require_path = 'lib'
  s.bindir = "bin"
  s.executables = ["autumn"]
  s.rubyforge_project = "pastr"

  s.add_dependency('facets')
  s.add_dependency('anise')
  s.add_dependency('english')
  s.add_dependency('daemons')

  s.post_install_message = <<MESSAGE.strip
============================================================

Thank you for installing Autumn!
You can now create a new bot:
# autumn create yourbot

============================================================
MESSAGE
}

Dir['tasks/*.rake'].each{|f| import(f) }

task :default => [:spec]

CLEAN.include %w[
  **/.*.sw?
  *.gem
  .config
  **/*~
  **/{data.db,cache.yaml}
  *.yaml
  pkg
  rdoc
  ydoc
  *coverage*
]
