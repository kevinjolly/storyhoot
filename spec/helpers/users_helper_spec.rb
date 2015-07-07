require 'rails_helper'

def login(user)
  visit login_path
  fill_in 'username_or_email', with: user.username
  fill_in 'password', with: 'secret'
  click_button 'Log In'
end