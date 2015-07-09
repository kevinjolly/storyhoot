class AdminMailer < ActionMailer::Base
  default from: "verifications@storyhoot.com"

  def request_verification(user, email)
    @email = user.email
    @user_id = user.id

    mail to: email, :subject => "Verification request"
  end
end
