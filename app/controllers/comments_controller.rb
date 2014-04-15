class CommentsController < ApplicationController

  before_filter :authenticate_user!, except: [:show, :index]
  before_filter :check_owner, except: [:index, :create]

  def index
    @comments = Comment.all
  end

  def create
    current_user.comments<<Comment.create(params[:comment])
    @comment = current_user.comments.last
    UserMailer.new_comment(@comment).deliver unless @comment.post.owner?(current_user)
    respond_to do |format|
      format.js do
      end  
    end
  end

  def edit
    respond_to do |format|
      format.html {render 'public/404'}
      format.js {}
    end  
  end

  def update
    @comment.update_attributes(params[:comment])
    respond_to do |format|
      format.html {render 'public/404'}
      format.js
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html {render 'public/404'}
      format.js
    end  
  end

  def check_owner
      @comment = Comment.find(params[:id])
      if @comment.owner?(current_user)
        @comment
      else
        render 'public/404'
      end    
    end
  
end
