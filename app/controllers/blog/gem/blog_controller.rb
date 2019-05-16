class Blog::Gem::BlogController < Blog::Gem::ApplicationController

  def index
    posts =  Blog::Gem::Post
    title = [t("blog.index.page_title")]
    if params[:q].present?
      title << "#{t("blog.search_by")} #{params[:q].humanize}"
      posts = posts.search(params[:q])
    elsif params[:tag].present?
      title << "#{t("blog.tagged_with")} #{params[:tag].humanize}"
      posts = posts.tagged_with(params[:tag])
    elsif params[:category].present?
      title << "#{t("blog.categoryed_with")} #{params[:category].humanize}"
      posts = posts.find_by_category(params[:category])
    elsif params[:author].present?
      @author = Blog::Gem::Author.find_by_url(params[:author])
      if @author.present?
        title << "#{t("blog.by_author")} #{@author.name}"
        posts = @author.posts
      end
    elsif params[:date].present?
      dt = DateTime.parse("3-#{params[:date]}")
      if dt.present?
        date = "#{I18n.l(dt, format: :month)} #{dt.year}"
        title << "#{t("blog.from_month")} #{date}"
        posts = posts.by_datetime(dt)
      else
        post = []
      end
    end
    @page_title = title.join(" ")
    respond_to do |format|
      format.atom do
        @posts = posts.published.all
        render layout: false
      end
      format.json do
        @posts = posts.published.limit(params[:limit]||Blog::Gem.per_page).offset(params[:offset]||0)
        render json: @posts.map{|x| {id: x.id, title: x.title, teaser: x.teaser, url: x.to_url, tags: x.tags, category: x.category, author: x.author_name, thumbnail: x.image_url, published_at: x.published_at, square: x.image_url(:square)}}
      end
      format.html do
        @current_path = blogs_path
        @posts = posts.published.paginate(page: params[:page].try(:gsub, "/", ""), per_page: Blog::Gem.per_page)
      end
    end
  end

  def show
    @post = Blog::Gem::Post.find_by_url(params[:name])
    if @post.present? && (current_author.present? || @post.published_at <= Time.now)
      @page_title = @post.title
      @description = @post.teaser
      @keywords = @post.tag_list.join(", ")
      @image = @post.thumbnail.url(:medium)
      @breadcrumbs_params = {name: @post.title}
      @current_path = blogs_path
    else
      render "layouts/application/not_found"
    end
  end

  def api
    @post = Blog::Gem::Post.find_by_id(params[:id])
    if @post.present? && @post.published_at <= Time.now
      render json: {status: 200, id: @post.id, title: @post.title, teaser: @post.teaser, url: @post.to_url, tags: @post.tags, category: @post.category, author: @post.author_name, thumbnail: @post.image_url, square: @post.image_url(:square), body: @post.body, published_at: @post.published_at}
    else
      render json: {status: 404}
    end

  end
end
