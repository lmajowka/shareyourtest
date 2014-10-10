FactoryGirl.define do
  factory :user do
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :exam do
    title    "Sample test title"
    description "Description of sample test"
    status "draft"
    price 0
    association :owner, factory: :user
  end
end
