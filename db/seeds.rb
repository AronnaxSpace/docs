# frozen_string_literal: true

require 'factory_bot_rails'
require 'faker'

(1..5).each do |i|
  user = User.find_or_initialize_by(
    email: "user_#{i}@aronnax.space",
    provider: :aronnax,
    uid: i
  )

  unless user.persisted?
    user.password = 'pass1234'
    user.password_confirmation = 'pass1234'
    user.save!

    p "user_#{i} was created"
  end

  next if user.projects.any?

  10.times { FactoryBot.create(:project, owner: user, is_public: rand(99).even?) }

  p "10 projects were created for user_#{i}"
end
