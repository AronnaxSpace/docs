FactoryBot.define do
  factory :category do
    project
    user { project.owner }

    name { Faker::Hipster.word }

    trait :subcategory do
      parent { create(:category) }
    end
  end
end
