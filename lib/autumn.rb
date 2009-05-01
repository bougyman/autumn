require "pathname"
module Autumn
  ROOT = Pathname.new(__FILE__).dirname.expand_path
  VERSION = "2.0.4"
end
$LOAD_PATH.unshift Autumn::ROOT
