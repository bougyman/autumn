require "pathname"
if Pathname.new(__FILE__).dirname.join("..", "lib", "autumn.rb").file?
  require Pathname.new(__FILE__).dirname.join("..", "lib", "autumn.rb")
else
  require "autumn"
end
