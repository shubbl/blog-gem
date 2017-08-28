class Blog::Gem::AuthorsController < Blog::Gem::ApplicationController

  before_action do |controller|
    disable_breadcrumb if defined?(disable_breadcrumb)
  end
  before_action :login_as_author, except: [:login, :login_submit]
  before_action :admin, only: [:index, :new, :create, :destroy]
  before_action :set_author, only: [:edit, :update, :destroy]

  def login_submit
    @page_title = "Author Login"
    if Blog::Gem::Author.find_by(public_email: params[:email]).try(:authenticate, params[:password])
      session[:author_id] = Blog::Gem::Author.find_by(public_email: params[:email]).id
      redirect_to blogs_path, notice: "You are Logged in!"
    else
      flash[:error] = "The password or email is incorrect."
      render :login
    end
  end

  def login
    if session[:author_id].present?
      redirect_to blogs_path
    end
    @page_title = "Author Login"
  end

  def logout
    session[:author_id] = nil
    redirect_to blogs_path
  end


  def index
    @authors = Blog::Gem::Author.all
    @page_title = "Listing Authors"
  end

  def new
    @author = Blog::Gem::Author.new
    @page_title = "New Authors"
  end

  def edit
  end

  def create
    @author = Blog::Gem::Author.new(author_params)
    respond_to do |format|
      if @author.save
        format.html { redirect_to "#{Blog::Gem.path}/authors/me/edit", notice: 'Author was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to "#{Blog::Gem.path}/authors/me/edit", notice: 'Author was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @author.destroy
    respond_to do |format|
      format.html { redirect_to authors_url, notice: 'Author was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def admin
      if !current_author.admin?
        redirect_to blogs_path
      end
    end

    def set_author
      if current_author.admin? && params[:id] != "me"
        @author = Blog::Gem::Author.find(params[:id])
      else
        @author = @current_author
      end
      @page_title = "Edit #{@author.name}"
    end

    def author_params
      params.require(:author).permit(:name, :private_email, :public_email, :password, :password_confirmation, :description, :shubbl_id, :facebook, :twitter, :xing, :instagram, :homepage, :github, :google_plus, :linkedin, :youtube, :phone, :mobile, :avatar_or_gravatar)
    end
end
