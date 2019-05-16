$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "blog/gem/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "blog-gem"
  s.version     = Blog::Gem::VERSION
  s.authors     = ["Vincent Thelang", "Michael Hoffmann"]
  s.email       = ["vincent.thelang@shubbl.de", "michael.hoffmann@shubbl.de"]
  s.homepage    = "https://www.shubbl.de/blog"
  s.summary     = "Blog Tool for the Shubbl Homepage"
  s.description = "Blog Tool for the Shubbl Homepage"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.4"

  s.add_dependency 'sass-rails', '~> 5.0'
  s.add_dependency "slim-rails"
  s.add_dependency "paperclip"
  s.add_dependency "acts-as-taggable-on"
  s.add_dependency "stringex"
  s.add_dependency "gravtastic"
  s.add_dependency 'bcrypt', '~> 3.1.7'
  s.add_dependency 'will_paginate'
  s.add_dependency 'will_paginate-bootstrap'
  s.add_dependency 'simple_form'
  s.add_dependency 'pg_search'
  s.add_dependency 'nokogiri'
end
