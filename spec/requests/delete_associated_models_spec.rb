require 'rails_helper'

describe 'Deleting users' do

  it 'should delete associated books' do
    user = FactoryGirl.create(:user)
    book = FactoryGirl.build(:book, user_id: user.id)
    book.category = FactoryGirl.build(:category)
    book.save!
    expect(book.user_id).to eq(user.id)
    expect(Book.count).to eq(1)
    user.destroy
    expect(Book.count).to eq(0)
  end

end

describe 'Deleting books' do

  it 'should delete associated comments' do
    book = FactoryGirl.build(:book)
    book.category = FactoryGirl.build(:category)
    book.save!
    comment = FactoryGirl.create(:comment, book_id: book.id)
    expect(comment.book_id).to eq(book.id)
    expect(Comment.count).to eq(1)
    book.destroy
    expect(Comment.count).to eq(0)
  end

  it 'should delete associated comments' do
    book = FactoryGirl.build(:book)
    book.category = FactoryGirl.build(:category)
    book.save!
    hashtag = FactoryGirl.create(:hashtag, book_id: book.id)
    expect(hashtag.book_id).to eq(book.id)
    expect(Hashtag.count).to eq(1)
    book.destroy
    expect(Hashtag.count).to eq(0)
  end

end