FactoryGirl.define do
  factory :user do
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :test do
    title    "Sample test title"
    description "Description of sample test"
  end
end
