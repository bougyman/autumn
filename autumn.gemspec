# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{autumn}
  s.version = "3.1.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tim 'riscfuture' Morgan"]
  s.date = %q{2009-05-03}
  s.default_executable = %q{autumn}
  s.description = %q{Autumn is a simple and modular irc framework}
  s.email = %q{bougy.man@gmail.com}
  s.executables = ["autumn"]
  s.files = ["AUTHORS", "CHANGELOG", "MANIFEST", "README", "README.textile", "Rakefile", "autumn.gemspec", "bin/autumn", "lib/autumn.rb", "lib/autumn/authentication.rb", "lib/autumn/channel_leaf.rb", "lib/autumn/coder.rb", "lib/autumn/console_boot.rb", "lib/autumn/ctcp.rb", "lib/autumn/daemon.rb", "lib/autumn/datamapper_hacks.rb", "lib/autumn/foliater.rb", "lib/autumn/formatting.rb", "lib/autumn/generator.rb", "lib/autumn/genesis.rb", "lib/autumn/inheritable_attributes.rb", "lib/autumn/leaf.rb", "lib/autumn/log_facade.rb", "lib/autumn/misc.rb", "lib/autumn/resources/daemons/Anothernet.yml", "lib/autumn/resources/daemons/AustHex.yml", "lib/autumn/resources/daemons/Bahamut.yml", "lib/autumn/resources/daemons/Dancer.yml", "lib/autumn/resources/daemons/GameSurge.yml", "lib/autumn/resources/daemons/IRCnet.yml", "lib/autumn/resources/daemons/Ithildin.yml", "lib/autumn/resources/daemons/KineIRCd.yml", "lib/autumn/resources/daemons/PTlink.yml", "lib/autumn/resources/daemons/QuakeNet.yml", "lib/autumn/resources/daemons/RFC1459.yml", "lib/autumn/resources/daemons/RFC2811.yml", "lib/autumn/resources/daemons/RFC2812.yml", "lib/autumn/resources/daemons/RatBox.yml", "lib/autumn/resources/daemons/Ultimate.yml", "lib/autumn/resources/daemons/Undernet.yml", "lib/autumn/resources/daemons/Unreal.yml", "lib/autumn/resources/daemons/_Other.yml", "lib/autumn/resources/daemons/aircd.yml", "lib/autumn/resources/daemons/bdq-ircd.yml", "lib/autumn/resources/daemons/hybrid.yml", "lib/autumn/resources/daemons/ircu.yml", "lib/autumn/resources/daemons/tr-ircd.yml", "lib/autumn/script.rb", "lib/autumn/speciator.rb", "lib/autumn/stem.rb", "lib/autumn/stem_facade.rb", "lib/autumn/tool/bin.rb", "lib/autumn/tool/create.rb", "lib/autumn/tool/project_creator.rb", "lib/autumn/version.rb", "lib/skel/Rakefile", "lib/skel/config/global.yml", "lib/skel/config/seasons/testing/database.yml", "lib/skel/config/seasons/testing/leaves.yml", "lib/skel/config/seasons/testing/season.yml", "lib/skel/config/seasons/testing/stems.yml", "lib/skel/leaves/administrator/README", "lib/skel/leaves/administrator/controller.rb", "lib/skel/leaves/administrator/views/autumn.txt.erb", "lib/skel/leaves/administrator/views/reload.txt.erb", "lib/skel/leaves/insulter/README", "lib/skel/leaves/insulter/controller.rb", "lib/skel/leaves/insulter/views/about.txt.erb", "lib/skel/leaves/insulter/views/help.txt.erb", "lib/skel/leaves/insulter/views/insult.txt.erb", "lib/skel/leaves/scorekeeper/README", "lib/skel/leaves/scorekeeper/config.yml", "lib/skel/leaves/scorekeeper/controller.rb", "lib/skel/leaves/scorekeeper/helpers/general.rb", "lib/skel/leaves/scorekeeper/models/channel.rb", "lib/skel/leaves/scorekeeper/models/person.rb", "lib/skel/leaves/scorekeeper/models/pseudonym.rb", "lib/skel/leaves/scorekeeper/models/score.rb", "lib/skel/leaves/scorekeeper/tasks/stats.rake", "lib/skel/leaves/scorekeeper/views/about.txt.erb", "lib/skel/leaves/scorekeeper/views/change.txt.erb", "lib/skel/leaves/scorekeeper/views/history.txt.erb", "lib/skel/leaves/scorekeeper/views/points.txt.erb", "lib/skel/leaves/scorekeeper/views/usage.txt.erb", "lib/skel/log/README", "lib/skel/log/testing.log", "lib/skel/script/console", "lib/skel/script/destroy", "lib/skel/script/generate", "lib/skel/shared/README", "lib/skel/tasks/app.rake", "lib/skel/tasks/db.rake", "lib/skel/tasks/doc.rake", "lib/skel/tasks/gem_installer.rake", "lib/skel/tasks/log.rake", "lib/skel/tasks/setup.rake", "lib/skel/tasks/spec.rake", "lib/skel/tmp/README", "spec/authentication_spec.rb", "spec/channel_leaf_spec.rb", "spec/coder_spec.rb", "spec/ctcp_spec.rb", "spec/daemon_spec.rb", "spec/datamapper_hacks_spec.rb", "tasks/authors.rake", "tasks/changelog.rake", "tasks/copyright.rake", "tasks/doc.rake", "tasks/gem.rake", "tasks/gem_installer.rake", "tasks/install_dependencies.rake", "tasks/manifest.rake", "tasks/rcov.rake", "tasks/release.rake", "tasks/reversion.rake", "tasks/setup.rake", "tasks/spec.rake"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/bougyman/autumn}
  s.post_install_message = %q{============================================================

Thank you for installing Autumn!
You can now create a new bot:
# autumn create yourbot

============================================================}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{pastr}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Autumn is a simple and modular irc framework}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<facets>, [">= 0"])
      s.add_runtime_dependency(%q<anise>, [">= 0"])
      s.add_runtime_dependency(%q<english>, [">= 0"])
      s.add_runtime_dependency(%q<daemons>, [">= 0"])
    else
      s.add_dependency(%q<facets>, [">= 0"])
      s.add_dependency(%q<anise>, [">= 0"])
      s.add_dependency(%q<english>, [">= 0"])
      s.add_dependency(%q<daemons>, [">= 0"])
    end
  else
    s.add_dependency(%q<facets>, [">= 0"])
    s.add_dependency(%q<anise>, [">= 0"])
    s.add_dependency(%q<english>, [">= 0"])
    s.add_dependency(%q<daemons>, [">= 0"])
  end
end
