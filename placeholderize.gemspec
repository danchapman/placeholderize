Gem::Specification.new do |s|
  s.name        = 'placeholderize'
  s.version     = '0.0.5'
  s.date        = '2014-06-11'
  s.summary     = "Make your SASS placeholders responsive."
  s.description = "A SASS mixin to generate placeholders that will work across all of your breakpoints."
  s.authors     = ["Daniel Chapman"]
  s.email       = 'dan@theclymb.com'
  s.homepage    =
    'http://rubygems.org/gems/placeholderize'
  s.license       = 'MIT'

   # Gem Files
  s.files = ["README.markdown"]
  s.files += ["CHANGELOG.markdown"]
  s.files += Dir.glob("lib/**/*.*")
  s.files += Dir.glob("stylesheets/**/*.*")

  # Gem Bookkeeping
  s.add_dependency("sass",      ["~>3.3.0"])
  s.add_dependency("breakpoint",   ["~>2.4.2"])
end
