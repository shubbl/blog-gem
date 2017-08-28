Blog::Gem::Engine.routes.draw do

  get "/" => "blog#index", as: :blogs

  get "/tag/:tag" => "blog#index", as: :blog_tag
  get "/category/:category" => "blog#index", as: :blog_category
  get "/archive/:date" => "blog#index", as: :blog_date
  get "/author/:author" => "blog#index", as: :blog_author
  get "/login" => "authors#login"
  post "/login" => "authors#login_submit", as: :author_login_submit
  get "/logout" => "authors#logout", as: :author_logout
  resources :authors, except: :show
  resources :posts, except: [:show, :index]

  get ":name" => "blog#show", as: :blog
end
