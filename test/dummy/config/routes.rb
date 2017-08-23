Rails.application.routes.draw do
  mount Blog::Gem::Engine => "/blog-gem"
end
