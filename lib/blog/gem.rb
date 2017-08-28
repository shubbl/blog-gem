require "pg_search"
require "paperclip"
require "sass-rails"
require "acts-as-taggable-on"
require "stringex"
require "gravtastic"
require "bcrypt"
require "will_paginate"
require "simple_form"
require "nokogiri"
require "blog/gem/engine"

module Blog
  module Gem
    class << self
        mattr_accessor :archive_count
        mattr_accessor :home_posts_count
        mattr_accessor :tags_count
        mattr_accessor :widget_posts_count
        mattr_accessor :categories
        mattr_accessor :path
        mattr_accessor :url
        mattr_accessor :image_path
        mattr_accessor :title_enable

        self.archive_count = 13
        self.home_posts_count = 6
        self.tags_count = 24
        self.widget_posts_count = 6
        self.categories = {}
        self.path = "/blog"
        self.image_path = "/uploads"
        self.title_enable = true
    end

     def self.setup(&block)
        yield self

        if Rails.env != "production"
            self.url = "http://localhost:3000"
        end
     end
  end
end
