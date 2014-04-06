class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  def new_comment(comment)
  	@user = comment.post.user
    @comment = comment
    @post = comment.post
    mail(to: @user.email, subject: 'New comment')
  end
end
