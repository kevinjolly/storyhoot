# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hashtag do
    content "MyString"
    tag "MyString"
    user_id 1
    book_id 1
  end
end
