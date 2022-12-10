# frozen_string_literal: true

# == Schema Information
#
# Table name: project_users
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  project_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_project_users_on_project_id              (project_id)
#  index_project_users_on_project_id_and_user_id  (project_id,user_id) UNIQUE
#  index_project_users_on_user_id                 (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#  fk_rails_...  (user_id => users.id)
#
class ProjectUser < ApplicationRecord
  belongs_to :project
  belongs_to :user
end
