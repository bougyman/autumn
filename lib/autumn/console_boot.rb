# Used by the script/console script to load the Autumn environment when IRb
# is executed.

require 'autumn/genesis'

# We set AL_ROOT in the script/console file to set it for the scope of that
# file. We have to set it again in here for the scope of the IRb session.
AL_ROOT = ENV["AUTUMN_ROOT"] || File.expand_path("#{File.dirname __FILE__}/..")
@genesis = Autumn::Genesis.new
@genesis.boot! false
