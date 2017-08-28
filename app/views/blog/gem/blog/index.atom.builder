atom_feed(language: 'de', url: root_url) do |feed|
  feed.title t("blog.index.page_title")
  feed.updated @posts.maximum(:published_at)

  @posts.each do |post|
    feed.entry post, {published: post.published_at, updated: post.updated_at} do |entry|
      entry.title post.title
      entry.content post.body, type: 'html'
      entry.author do |author|
        author.name post.author.name
      end
      entry.url post_url(post)
      entry.summary post.teaser, type: 'html'
    end
  end
end
