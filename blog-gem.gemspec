$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "blog/gem/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "blog-gem"
  s.version     = Blog::Gem::VERSION
  s.authors     = ["Vincent"]
  s.email       = ["vincent@vincent-thelang.de"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Blog::Gem."
  s.description = "TODO: Description of Blog::Gem."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.4"

  s.add_development_dependency "sqlite3"
end
