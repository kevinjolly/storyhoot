require 'rails_helper'

describe 'Views' do
  it 'should start with zero views' do
    book = FactoryGirl.build(:book)
    book.category = FactoryGirl.build(:category)
    book.save!
    expect(book.impressionist_count).to eq(0)
  end

  it 'should increment views on visiting show page' do
    user = FactoryGirl.create(:user)
    visit login_path
    fill_in 'username_or_email', with: user.username
    fill_in 'password', with: 'secret'
    click_button 'Log In'
    expect(page).to_not have_content('Log in')

    book = FactoryGirl.build(:book)
    book.category = FactoryGirl.build(:category)
    book.save!
    expect(book.impressionist_count).to eq(0)
    visit book_path(book)
    expect(book.impressionist_count).to eq(1)
  end
end