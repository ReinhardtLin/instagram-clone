class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def new_comment(user, comment)
    @user = user
    @comment = comment

    mail(:to => user.email, :subject => "New Comment")
  end

end
