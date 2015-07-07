require 'rails_helper'

describe 'User registration' do

  let(:user) { FactoryGirl.create(:user) }
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:user3) { FactoryGirl.create(:user) }
  let(:user4) { FactoryGirl.create(:user) }
  let(:user5) { FactoryGirl.create(:user) }

  it 'should allow the user to choose 5 authors to subscribe to' do
    visit login_path
    fill_in 'username_or_email', with: user.username
    fill_in 'password', with: 'secret'
    click_button 'Log In'
    expect(current_path).to eq(find_authors_path)
  end
end
