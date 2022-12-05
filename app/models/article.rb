# == Schema Information
#
# Table name: articles
#
#  id          :bigint           not null, primary key
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint
#  project_id  :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_articles_on_category_id  (category_id)
#  index_articles_on_project_id   (project_id)
#  index_articles_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (project_id => projects.id)
#  fk_rails_...  (user_id => users.id)
#
class Article < ApplicationRecord
  has_rich_text :content

  # associations
  belongs_to :user
  belongs_to :project
  belongs_to :category

  # validations
  validates :title, presence: true
end
