require "pathname"
module Autumn
  unless Autumn.const_defined?("ROOT")
    ROOT = Pathname.new(__FILE__).dirname.expand_path
  end
end
$LOAD_PATH.unshift Autumn::ROOT
require "autumn/version"
