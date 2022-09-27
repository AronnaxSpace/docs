# == Schema Information
#
# Table name: projects
#
#  id          :bigint           not null, primary key
#  description :text
#  is_public   :boolean          default(FALSE)
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :integer
#
# Indexes
#
#  index_projects_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
FactoryBot.define do
  factory :project do
    name { "MyString" }
    description { "MyText" }
    user { nil }
  end
end
