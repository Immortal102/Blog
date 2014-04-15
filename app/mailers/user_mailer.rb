class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def new_comment(comment)
  	if @user = comment.post.user
      @comment = comment
      @post = comment.post
      mail(to: @user.email, subject: 'New comment')
    end
  end

  def new_user(user)
    @email = user.email
    mail(to: @email, subject: 'Welcome!!!')
  end
end
