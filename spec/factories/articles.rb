FactoryBot.define do
  factory :article do
    category
    project { category.project }
    user { project.owner }

    title { Faker::Lorem.sentence }
  end
end
