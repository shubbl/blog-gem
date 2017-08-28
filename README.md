# Shubbl - Blog::Gem
Blog Tool for the Shubbl Homepage

## Demo: https://www.shubbl.de/blog

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'blog-gem'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install blog-gem
```

## Setup


###Install the migration to create the data table:

For Acts as taggable on
```bash
rake acts_as_taggable_on_engine:install:migrations
```
```bash
rake blog_gem:install:migrations
rake db:migrate
```

###Into your routes.rb
```ruby
  mount Blog::Gem::Engine => "/blog", :as => :blogs
```

###Into your style.sass
```
@import blog
```
###Into your application.js
```
//= require blog
```
###Into rails c
```ruby
Blog::Gem::Author.create_admin(name: "", password: "", email: "")
```

### Add to your Meta Tag View
```ruby
<%= yield :meta %>
```
### You can use the globel variabel outside of the blog#show
```ruby
@page_title: title
@description: teaser
@keywords: tag_list (join with ',' )
@image: thumbnail_url
@current_path
```

## Config

##Create config/initializers/blog.rb, yout can modify:

```ruby
Blog::Gem.setup do |config|
  config.categories = {
    "name of the categorie" => id,
    "shubbl" => 0,
    "tipps" => 1,
    "story" => 2,
    "porträt" => 3,
    "dating" => 4,
    "lifestyle" => 5,
    "kolumne" => 6,
    "spotlight" => 7,
  }
  config.url = "https://www.shubbl.de" # In development: http://localhost:3000
  config.archive_count = 13
  config.home_posts_count = 6
  config.tags_count = 24
  config.widget_posts_count = 6
  config.path = "/blog"
  config.image_path = "/uploads"
  config.title_enable = true

end
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
