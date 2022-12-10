# frozen_string_literal: true

# == Schema Information
#
# Table name: projects
#
#  id          :bigint           not null, primary key
#  description :text
#  is_public   :boolean          default(FALSE)
#  name        :string           default(""), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :bigint
#
# Indexes
#
#  index_projects_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
class Project < ApplicationRecord
  # associations
  belongs_to :owner,
             class_name: 'User',
             foreign_key: 'owner_id'
  has_many :categories, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :project_users
  has_many :users, through: :project_users

  # validations
  validates :name, presence: true

  # scopes
  scope :not_private, -> { where(is_public: true) }
  scope :all_for, lambda { |user|
    where(is_public: true)
      .or(where(owner_id: user.id))
      .or(where(id: user.project_ids))
  }
end
