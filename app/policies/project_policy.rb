# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def show?
    return true if record.is_public?
    return true if record.owner == user
    return true if record.user_ids.include?(user.id)

    false
  end

  def edit?
    update?
  end

  def update?
    return true if record.owner == user

    false
  end

  def destroy?
    update?
  end
end
