if (defined? Compass)
  require 'breakpoint'
  Compass::Frameworks.register(
    "placeholderize",
    :path => "#{File.dirname(__FILE__)}/.."
  )
end

module Placeholderize
  VERSION = "0.0.1"
  DATE = "2014-03-30"
end
