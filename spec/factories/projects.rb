FactoryBot.define do
  factory :project do
    association :owner, factory: :user

    name { Faker::Lorem.sentence }

    trait :not_private do
      is_public { true }
    end

    trait :with_description do
      description { Faker::Lorem.paragraph }
    end
  end
end
