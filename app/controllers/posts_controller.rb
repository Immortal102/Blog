class PostsController < ApplicationController

  before_filter :authenticate_user!, except: [:show, :index]

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
    current_user.posts<<Post.create(params[:post])
    redirect_to root_path
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
    @post = Post.find(params[:id])
    render 'public/404' unless @post.owner?(current_user)
  end

  def update
    Post.find(params[:id]).update_attributes(params[:post])
    redirect_to root_path
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.owner?(current_user)
      @post.destroy
      redirect_to root_path
    else
      render 'public/404'
    end  
  end
end
