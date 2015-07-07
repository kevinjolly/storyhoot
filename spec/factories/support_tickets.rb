# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :support_ticket do
    name "MyString"
    email "MyString"
    title "MyString"
    question "MyText"
  end
end
