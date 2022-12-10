# frozen_string_literal: true

module ProjectScoped
  extend ActiveSupport::Concern

  included do
    before_action :authorize_project
    helper_method :project
  end

  private

  def project
    @project ||= Project.find(params[:project_id])
  end

  def authorize_project
    authorize project, :show?
  end
end
