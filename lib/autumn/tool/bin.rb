#!/usr/bin/env ruby
require 'optparse'
### This module offers the functionality to start, stop, restart, create,
### Check status, or run a console of an autumn application
### see autumn -h for usage
module Autumn
  module Tool
    module Bin
      module Helpers # Helper methods {{{

        def default_pidfile # {{{
          return @default_pidfile if @default_pidfile
          al_root
          pn = Pathname.new(AL_ROOT)
          @default_pidfile = (pn.expand_path.join("tmp", pn.basename.to_s + ".pid")).strip
        end # }}}

        # We're really only concerned about win32ole, so we focus our check on its
        # ability to load that
        def is_windows?  # {{{
          return @is_win if @is_win
          begin
            require "win32ole"
          rescue LoadError
          end
          @is_win ||= Object.const_defined?("WIN32OLE")
        end # }}}

        def is_running?(pid) # {{{
          if is_windows?
            wmi = WIN32OLE.connect("winmgmts://")
            processes, ours = wmi.ExecQuery("select * from win32_process where ProcessId = #{pid}"), []
            processes.each { |process| ours << process.Name }
            ours.first.nil?
          else
            begin
              prio = Process.getpriority(Process::PRIO_PROCESS, pid)
              true
            rescue Errno::ESRCH
              false
            end
          end
        end # }}}

        def check_running?(pid_file) # {{{
          return false unless File.file?(pid_file)
          is_running?(File.read(pid_file).to_i)
        end # }}}

        def find_pid(pid_file) # {{{
          if pid_file.nil? or not File.file?(pid_file)
            pid_file = default_pidfile
          end
          unless File.file?(pid_file)
            $stderr.puts "Could not find running process id."
            return false
          end
          pid_file
        end # }}}
      end # End helper methods }}}

      class Cmd # This class contains the command methods {{{
        include Helpers
        attr_accessor :command

        def initialize(args = nil)
          args ||= ARGV
          raise "arguments must be an array!" unless args.respond_to?(:detect)
          @ourargs = args.dup
          @command = args.detect { |arg| arg.match(/^(?:--?)?(?:start|stop|restart|create|h(?:elp)?|v(?:ersion)?|console|status)/) }
          if command.nil?
            @command = ""
          else
            args.delete(@command)
          end
          ARGV.replace(args)
        end

        # {{{ #run is called when we're interactive ($0 == __FILE__)
        def self.run(args = nil)
          cmd = new(args)
          case cmd.command
          when /^(?:--?)?status$/
            cmd.status(cmd.command)
          when /^(?:--?)?restart$/
            cmd.stop(cmd.command)
            cmd.start
          when /^(?:--?)?start$/
            cmd.start
          when /^(?:--?)?create$/
            cmd.create(cmd.command)
          when /^(?:--?)?stop$/
            if cmd.stop(cmd.command)
              puts "Autumn session has ended."
              $stdout.flush
            else
              puts "Autumn failed to stop (or was not running)"
            end
          when /^(?:--?)?console$/
            require "irb"
            require "irb/completion"
            cmd.include_autumn
            require "lib/genesis"
            IRB.start
            puts "Autumn session has ended."
          when /^(?:--?)?h(elp)?$/
            puts cmd.usage
          when /^(?:--?)?v(ersion)?$/
            cmd.include_autumn
            puts Autumn::VERSION
            exit
          when /^$/
            puts "Must supply a valid command"
            puts cmd.usage
            exit 1
          else
            puts "#{command} not implemented"
            puts cmd.usage
            exit 1
          end
        end # }}}

        def include_autumn # {{{
          begin
            $LOAD_PATH.unshift File.join(File.dirname(__FILE__), '/../lib')
            require 'autumn'
          rescue LoadError
            $LOAD_PATH.shift

            begin
              require 'rubygems'
            rescue LoadError
            end
            require 'autumn'
          end
        end # }}}

        def usage # {{{
          txt = [
            "\n  Usage:", 
            "autumn <start|stop|restart|status|create|console> PROJECT [options]\n",
            "Commands:\n",
            " start   - Starts an instance of this application.\n",
            " stop    - Stops a running instance of this application.\n",
            " restart - Stops running instance of this application, then starts it back up.  Pidfile",
            "           (if supplied) is used for both stop and start.\n",
            " status  - Gives status of a running autumn instance\n",
            " create  - Creates a new prototype Autumn application in a directory named PROJECT in",
            "           the current directory.  autumn create foo would make ./foo containing an",
            "           application prototype.\n",
            " console - Starts an irb console with autumn (and irb completion) loaded.",
            "           ARGV is passed on to IRB.\n\n"
          ].join("\n\t")

          txt <<  "* All commands take PROJECT as the directory the autumn bot lives in.\n\n"
          txt << start_options.to_s << "\n"
          txt << create_options.to_s << "\n"
          #if is_windows?
            #txt << %x{ruby #{rackup_path} --help}.split("\n").reject { |line| line.match(/^Usage:/) }.join("\n\t")
          #else
            #txt << %x{#{rackup_path} --help}.split("\n").reject { |line| line.match(/^Usage:/) }.join("\n\t")
          #end
        end # }}}

        def start_options
          @start_opts ||= OptionParser.new do |o|
            o.banner = "Start/Restart Options"
            o.on("-D", "--daemonize", "Daemonize the process") { |daem| @daemonize = true }
          end
        end

        def al_root
          require "pathname"
          dir = nil
          if ARGV.size == 1
            dir = Pathname.new(ARGV.shift)
          elsif ARGV.size > 1
            $stderr.puts "Unknown options given #{ARGV.join(" ")}"
            puts usage
            exit 1
          end
          if dir.nil? or not dir.directory?
            dir = Pathname.new(ENV["PWD"]).expand_path
            $stderr.puts "Path to autumn tree not given or invalid, using #{dir}"
          end
          Object.const_set("AL_ROOT", dir.expand_path.to_s)
          Dir.chdir(AL_ROOT)
        end

        ### Methods for commands {{{
        def start # {{{
          start_options.parse!(ARGV)
          al_root
          
          # Find the name of this app
          puts "starting autumn"
          if @daemonize
            require "daemons"
            Daemons.run_proc(Pathname.new(AL_ROOT).basename, :ARGV => ["start"], :dir_mode => :normal, :dir => "tmp", :multiple => false) do
              start_autumn
            end
            puts "Autumn started in the background"
          else
            start_autumn
          end
        end # }}}

        def start_autumn
          require "autumn/genesis"
          puts "Loading Autumn #{Autumn::VERSION}"
          Autumn::Genesis.new.boot!
        end

        def create_options(opts = {})
          @create_opts ||= OptionParser.new do |o|
            o.banner = "Create Options"
            o.on("-f", "--force", "Force creation if dir already exists") { |yn| opts[:force] = true }
            o.on("-a", "--amend", "Update a tree") { |yn| opts[:amend] = true }
          end
        end
        
        def create(command) # {{{
          create_options(opts = {}).parse!(ARGV)
          unless ARGV.size == 1
            $stderr.puts "Invalid options given: #{ARGV.join(" ")}"
            exit 1
          end
          project_name = ARGV.shift
          if project_name.nil?
            $stderr.puts "Must supply a valid project name, you gave none."
            puts usage
            exit 1
          end
          include_autumn
          require 'autumn/tool/create'
          Autumn::Tool::Create.create(project_name, opts)
        end # }}}

        def stop(command) # {{{
          al_root
          require "daemons"
          Daemons.run_proc(Pathname.new(AL_ROOT).basename, :ARGV => ["stop"], :dir_mode => :normal, :dir => "tmp", :multiple => false) do
            start_autumn
          end
        end # }}}

        def status(command) # {{{
          al_root
          pn = Pathname.new(AL_ROOT)
          unless pid_file = find_pid(pn.join("tmp", pn.basename.to_s + ".pid"))
            $stderr.puts "No pid_file found! Autumn may not be started."
            exit 1
          end
          puts "Pid file #{pid_file} found, PID is #{pid = File.read(pid_file).chomp}"
          unless is_running?(pid.to_i)
            $stderr.puts "PID #{pid} is not running"
            exit 1
          end
          if is_windows?
            wmi = WIN32OLE.connect("winmgmts://")
            processes, ours = wmi.ExecQuery("select * from win32_process where ProcessId = #{pid}"), []
            processes.each { |p| ours << [p.Name, p.CommandLine, p.VirtualSize, p.CreationDate, p.ExecutablePath, p.Status ] }
            puts "Autumn is running!\n\tName: %s\n\tCommand Line: %s\n\tVirtual Size: %s\n\tStarted: %s\n\tExec Path: %s\n\tStatus: %s" % ours.first
          else
            require "pathname"
            # Check for /proc
            if File.directory?(proc_dir = Pathname.new("/proc"))
              proc_dir = proc_dir.join(pid)
              # If we have a "stat" file, we'll assume linux and get as much info
              # as we can
              if stat_file = proc_dir.join("stat") and stat_file.file?
                stats = File.read(stat_file).split
                puts "Autumn is running!\n\tCommand Line: %s\n\tVirtual Size: %s\n\tStarted: %s\n\tExec Path: %s\n\tStatus: %s" % [
                  File.read(proc_dir.join("cmdline")).split("\000").join(" "),
                  "%s k" % (stats[22].to_f / 1024),
                  File.mtime(proc_dir),
                  File.readlink(proc_dir.join("exe")),
                  stats[2]
                ]
                exit
              end
            end
            # Fallthrough status, just print a ps
            puts "Autumn process #{pid} is running!"
            begin
              puts %x{ps l #{pid}}
            rescue
              puts "No further information available"
            end
          end
        end # }}}

        ### End of command methods }}}
      end # }}}
    end
  end
end

if $0 == __FILE__
  Autumn::Tool::Bin::Cmd.run(ARGV)
end
