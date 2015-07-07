require 'rails_helper'

describe 'PasswordResets' do
  it 'emails user when requesting password reset' do
    user = FactoryGirl.create(:user)
    visit login_path
    click_link 'password'
    fill_in 'email', with: user.email
    click_button 'Reset my password'
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Email sent')
    expect(last_email.to).to include(user.email)
  end

  it 'does not email invalid user when requesting password reset' do
    visit login_path
    click_link 'password'
    fill_in 'email', with: 'npbody@example.com'
    click_button 'Reset my password'
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Email sent')
    expect(last_email).to be_nil
  end

  it 'does not update the user password when confirmation fails' do
    user = FactoryGirl.create(:user, password_reset_token: 'something', password_reset_sent_at: 1.hour.ago)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in 'new_password', with: 'foobar'
    fill_in 'confirm_password', with: 'somethingelse'
    click_button 'Change Password'
    expect(current_path).to eq(login_path)
    expect(page).to have_content('errors')
  end

  it 'updates the user password when confirmation passes' do
    user = FactoryGirl.create(:user, password_reset_token: 'something', password_reset_sent_at: 1.hour.ago)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in 'new_password', with: 'foobar'
    fill_in 'confirm_password', with: 'foobar'
    click_button 'Change Password'
    expect(current_path).to eq(login_path)
    expect(page).to have_content('Password has been reset')
  end
end
