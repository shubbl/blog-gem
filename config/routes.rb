Blog::Gem::Engine.routes.draw do

  get "/" => "blog#index", as: :blogs
  get "/feed.atom" => "blog#index", as: :blog_feed
  get "/api" => "blog#index", as: :blog_api_index, format: "json"
  get "/api/:id" => "blog#api", as: :blog_api_show, format: "json"
  get "/api/:id" => "blog#api", as: :post_path

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
