require "rails_helper"

RSpec.describe UserMailer, :type => :mailer do
  describe "password_reset" do

    let(:user) { FactoryGirl.create(:user, password_reset_token: 'anything') }
    let(:mail) { UserMailer.password_reset(user) }

    it "sends user password reset url" do
      expect(mail.subject).to eq("Storyhoot Password Reset")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["storyhoot_support@storyhoot.com"])
      expect(mail.body.encoded).to match(edit_password_reset_path(user.password_reset_token))
    end

  end
end
