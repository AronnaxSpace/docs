# frozen_string_literal: true

module CategoryScoped
  extend ActiveSupport::Concern

  include ProjectScoped

  included do
    helper_method :category
  end

  private

  def category
    @category ||= project.categories.find(params[:category_id])
  end
end
