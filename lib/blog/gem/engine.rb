module Blog
  module Gem
    class Engine < ::Rails::Engine
      isolate_namespace Blog::Gem
    end
  end
end
