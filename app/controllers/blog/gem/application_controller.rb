class Blog::Gem::ApplicationController < ::ApplicationController
  helper_method :current_author

  def login_as_author
    current_author = Blog::Gem::Author.find_by_id(session[:author_id])
    if current_author.blank?
      redirect_to blogs_path
    end
  end

  def current_author
    return @current_author if @current_author.present?
    @current_author = Blog::Gem::Author.find_by_id(session[:author_id])
  end
end
