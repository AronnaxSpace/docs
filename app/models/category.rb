# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :bigint
#  project_id :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_categories_on_parent_id   (parent_id)
#  index_categories_on_project_id  (project_id)
#  index_categories_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => categories.id)
#  fk_rails_...  (project_id => projects.id)
#  fk_rails_...  (user_id => users.id)
#
class Category < ApplicationRecord
  # associations
  belongs_to :project
  belongs_to :user
  belongs_to :parent,
             class_name: 'Category',
             optional: true
  has_many :children,
           class_name: 'Category',
           foreign_key: :parent_id,
           dependent: :nullify
  has_many :articles, dependent: :nullify

  # validations
  validates :name, presence: true
  validate :cannot_have_itself_as_a_patent
  validate :subcategories_cannot_have_children_categories

  # scopes
  scope :root, -> { where(parent_id: nil) }

  private

  def cannot_have_itself_as_a_patent
    return unless self == parent

    errors.add(:base, :cannot_have_itself_as_a_patent)
  end

  def subcategories_cannot_have_children_categories
    return unless parent&.parent.present? || (parent.present? && children.any?)

    errors.add(:base, :subcategories_cannot_have_children_categories)
  end
end
