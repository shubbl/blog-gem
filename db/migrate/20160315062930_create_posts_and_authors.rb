class CreatePostsAndAuthors < ActiveRecord::Migration
  def change
    create_table "blog_gem_posts", force: :cascade do |t|
      t.string   "title"
      t.text     "body"
      t.text     "teaser"
      t.datetime "published_at"
      t.integer  "author_id"
      t.integer  "category_id"
      t.datetime "created_at",             null: false
      t.datetime "updated_at",             null: false
      t.string   "thumbnail_file_name"
      t.string   "thumbnail_content_type"
      t.integer  "thumbnail_file_size"
      t.datetime "thumbnail_updated_at"
      t.string   "url"
      t.boolean  "show_author"
      t.string   "path"
    end
    create_table "blog_gem_authors", force: :cascade do |t|
      t.string   "name"
      t.string   "private_email"
      t.string   "public_email"
      t.string   "password_digest"
      t.text     "description"
      t.integer  "shubbl_id"
      t.string   "facebook"
      t.string   "twitter"
      t.string   "xing"
      t.string   "instagram"
      t.string   "homepage"
      t.string   "github"
      t.string   "google_plus"
      t.string   "linkedin"
      t.string   "youtube"
      t.string   "phone"
      t.string   "mobile"
      t.string   "avatar_or_gravatar"
      t.boolean  "admin"
      t.datetime "created_at",          null: false
      t.datetime "updated_at",          null: false
      t.string   "avatar_file_name"
      t.string   "avatar_content_type"
      t.integer  "avatar_file_size"
      t.datetime "avatar_updated_at"
      t.string   "url"
    end

  end
end
