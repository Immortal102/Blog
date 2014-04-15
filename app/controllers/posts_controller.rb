class PostsController < ApplicationController

  before_filter :authenticate_user!, except: [:show, :index]
  before_filter :check_owner, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
    if user_signed_in?
      @my_posts = current_user.posts
      @my_comments = current_user.comments
    end  
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    if @post.valid?
      current_user.posts<<@post
      redirect_to post_path(@post), notice: 'Your post successfully created.'
    else
      render :new
    end  
  end

  def show
    begin
      @post = Post.find(params[:id])
      @comments = @post.comments
    rescue ActiveRecord::RecordNotFound
      render 'public/404'
    end  
  end

  def edit

  end

  def update
    if @post.update_attributes(params[:post])
      redirect_to root_path, notice: 'Your post successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: 'Was deleted successfully'
  end

  private

    def check_owner
      @post = Post.find(params[:id])
      if @post.owner?(current_user)
        @post
      else
        render 'public/404'  
      end
    end
end
