# frozen_string_literal: true

class CategoriesController < ApplicationController
  include ProjectScoped

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new(category_params)
    @category.project = project
    @category.user = current_user

    respond_to do |format|
      @category.save

      format.turbo_stream
    end
  end

  def update
    respond_to do |format|
      category.update(category_params)

      format.turbo_stream
    end
  end

  def destroy
    respond_to do |format|
      category.destroy

      format.turbo_stream
    end
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
