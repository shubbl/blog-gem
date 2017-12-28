class Blog::Gem::Post < Blog::Gem::ApplicationRecord
  include ::PgSearch

  belongs_to :author

  acts_as_taggable

  has_attached_file :thumbnail, styles: { medium: "750x300#", square: "80x80#"}, path: ":rails_root/public#{Blog::Gem.image_path}/posts/:id/:style.:extension", url: "#{Blog::Gem.image_path}/posts/:id/:style.:extension"
  validates_attachment_content_type :thumbnail, content_type: /\Aimage\/.*\Z/

  acts_as_url :title

  before_save{self.url = self.title.to_url}

  pg_search_scope :search, :against => [:title, :body, :teaser]

  scope :find_by_category, -> (name) { where(category_id: Blog::Gem.categories[name]) }
  scope :by_datetime, -> (dt) { where("published_at >= ? and published_at <= ?", dt.beginning_of_month, dt.end_of_month) }
  scope :published, -> { where("published_at <= ?", Time.now).order('published_at desc') }
  scope :unpublished, -> { where("published_at > ?", Time.now).order('published_at desc') }

  def author_name
    if author.present? && show_author
      author.name
    end
  end

  def image_url(type=:medium)
    "#{Blog::Gem.url}#{thumbnail.url(type)}"
  end

  def to_path
    "#{Blog::Gem.path}/#{url}"
  end

  def to_url
    "#{Blog::Gem.url}#{to_path}"
  end

  def tags
    tag_list.join(", ")
  end

  def category
    if category_id.present?
      category = Blog::Gem.categories.index(category_id)
      {name: category.humanize, link: "#{Blog::Gem.path}/category/#{category}"}
    else
      {name: "<i>#{I18n.t("blog.no_category")}</i>", link: Blog::Gem.path}
    end
  end
end
