FactoryGirl.define do
  factory :user do
  	sequence(:username)  { |n| "Person #{n}" }
  	sequence(:name) { |n| "person #{n}"}
  	sequence(:email) { |n| "person#{n}@example.com"}
    password 'secret'
    activation_state 'active'
  end
end
