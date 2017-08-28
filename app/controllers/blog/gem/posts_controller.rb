class Blog::Gem::PostsController < Blog::Gem::ApplicationController
  before_action :login_as_author
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :disable_breadcrumb if defined?(disable_breadcrumb)

  def new
    @post = Blog::Gem::Post.new(author_id: current_author.id, show_author: true)
    @page_title = "New Blog Post"
  end

  def edit
  end

  def create
    @post = Blog::Gem::Post.new(post_params)

    if !current_author.admin?
      @post.author_id = current_author.id
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post.to_path, notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    if !current_author.admin?
      post_params[:author_id] = current_author.id
    end
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post.to_path, notice: 'Post was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Post was successfully destroyed.' }
    end
  end

  private
    def set_post
      if current_author.admin?
        @post = Blog::Gem::Post.find(params[:id])
      else
        @post = current_author.posts.find(params[:id])
      end
      @page_title = "Edit #{@post.title}"
    end

    def post_params
      params.require(:post).permit(:title, :body, :teaser, :published_at, :author_id, :category_id, :tag_list, :thumbnail, :show_author, :path)
    end
end
