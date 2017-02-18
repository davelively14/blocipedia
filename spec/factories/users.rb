FactoryGirl.define do
  pw = Faker::Internet.password

  factory :user do
    sequence(:email){|n| "user#{n}@blocipedia.io"}
    password pw
    password_confirmation pw
  end
end
