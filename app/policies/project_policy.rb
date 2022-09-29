# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    return true if record.owner == user
    return true if record.is_public?

    false
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    return true if record.owner == user

    false
  end

  def edit?
    update?
  end

  def destroy?
    return true if record.owner == user

    false
  end
end
