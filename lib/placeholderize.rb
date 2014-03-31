if (defined? Compass)
  require 'breakpoint'
  Compass::Frameworks.register(
    "placeholderize",
    :path => "#{File.dirname(__FILE__)}/.."
  )
end
