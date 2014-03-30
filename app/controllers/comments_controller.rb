class CommentsController < ApplicationController

  before_filter :authenticate_user!, except: [:show, :index]

  def index
    @comments = Comment.all
  end

  def new
  end

  def create
    respond_to do |format|
      format.html {}
      format.js do
        current_user.comments<<Comment.create(params[:comment])
        @comment = Comment.last
      end  
    end
  end

  def show
  end

  def edit
  end

  def update
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
