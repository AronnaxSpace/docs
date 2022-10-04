FactoryBot.define do
  factory :category do
    project
    user

    name { Faker::Hipster.word }
  end
end
