# == Schema Information
#
# Table name: users
#
#  id                    :bigint           not null, primary key
#  aronnax_access_token  :string
#  aronnax_refresh_token :string
#  email                 :string           default(""), not null
#  encrypted_password    :string           default(""), not null
#  provider              :string
#  remember_created_at   :datetime
#  uid                   :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
