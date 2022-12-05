# frozen_string_literal: true

class CategoriesController < ApplicationController
  include ProjectScoped

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new(category_params.merge(project:, user: current_user))

    category.save
  end

  def update
    category.update(category_params)
  end

  def destroy
    category.destroy!
  end

  private

  def category
    @category ||= Category.find(params[:id])
  end
  helper_method :category

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end
end
