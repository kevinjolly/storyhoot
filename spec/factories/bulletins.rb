# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bulletin do
    user nil
    content "MyString"
    url "MyString"
  end
end
