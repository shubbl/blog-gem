atom_feed(language: 'de', url: Blog::Gem.url) do |feed|
  feed.title t("blog.index.page_title")
  feed.updated @posts.maximum(:updated_at)

  @posts.each do |post|
    feed.entry post, {published: post.published_at, updated: post.updated_at, url: post.to_url} do |entry|
      entry.title post.title
      entry.content post.body, type: 'html'
      entry.author do |author|
        author.name post.author_name
      end
      entry.url post.to_url
      entry.summary post.teaser, type: 'html'
    end
  end
end
