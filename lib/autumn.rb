require "pathname"
module Autumn
  ROOT = Pathname.new(__FILE__).dirname.expand_path
end
$LOAD_PATH.unshift Autumn::ROOT
require "autumn/version"
