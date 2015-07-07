class UserMailer < ActionMailer::Base
  default from: "storyhoot_support@storyhoot.com"

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'Storyhoot Password Reset'
  end

  def activation_needed_email(user)
    @user = user
    @url  = "http://storyhoot.com/u/#{user.activation_token}/activate"
    mail :to => user.email, :subject => "Activate your Storyhoot account"
  end

  def activation_success_email(user)
    @user = user
    @url  = "http://storyhoot.com/login"
    mail :to => user.email, :subject => "Your account is now activated"
  end
end
