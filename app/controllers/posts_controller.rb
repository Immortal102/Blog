class PostsController < ApplicationController

  before_filter :authenticate_user!, except: [:show, :index]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    current_user.posts<<Post.create(params[:post])
    redirect_to root_path
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    Post.find(params[:id]).update_attributes(params[:post])
    redirect_to root_path
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to root_path
  end
end
