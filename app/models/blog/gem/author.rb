class Blog::Gem::Author < Blog::Gem::ApplicationRecord
  include Gravtastic

  size = 512

  gravtastic :private_email, size: size

  has_secure_password
  has_many :posts

  acts_as_taggable_on :keywords
  has_attached_file :avatar, styles: {image: "#{size}x#{size}>" }, path: ":rails_root/public#{Blog::Gem.image_path}/authors/:id/:style.:extension", url: "#{Blog::Gem.image_path}/authors/:id/:style.:extension"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  acts_as_url :name

  before_save{self.url = self.name.to_url}

  def to_path
    "#{Blog::Gem.path}/author/#{url}"
  end

  def self.create_admin(name:, password:, email:)
    create(name: name, password: password, password_confirmation: password, private_email: email, public_email: email, admin: true)
  end

  def image
    if avatar_or_gravatar == "avatar"
      avatar.url(:image)
    else
      gravatar_url
    end
  end
end
