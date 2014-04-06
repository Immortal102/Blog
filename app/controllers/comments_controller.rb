class CommentsController < ApplicationController

  before_filter :authenticate_user!, except: [:show, :index]

  def index
    @comments = Comment.all
  end

  def new
  end

  def create
    respond_to do |format|
      format.js do
        current_user.comments<<Comment.create(params[:comment])
        @comment = current_user.comments.last
        UserMailer.new_comment(@comment).deliver unless @comment.post.owner?(current_user)
      end  
    end
  end

  def show
  end

  def edit
    respond_to do |format|
      format.html {render 'public/404'}
      format.js {@comment = Comment.find(params[:id])}
    end  
  end

  def update
    respond_to do |format|
      format.js do 
        @comment = Comment.find(params[:id])
        @comment.update_attribute(:body, params[:comment][:body])
      end
    end
  end

  def destroy
    respond_to do |format|
      format.js  do
        @comment = Comment.find(params[:id])
        @comment.destroy
      end  
    end  
  end
  
end
