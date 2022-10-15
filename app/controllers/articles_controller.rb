# frozen_string_literal: true

class ArticlesController < ApplicationController
  include CategoryScoped

  def new
    @article = Article.new
  end

  def edit; end

  def create
    @article = Article.new(article_params.merge(category:, project:, user: current_user))

    article.save
  end

  def update
    article.update(article_params)
  end

  def destroy
    article.destroy!
  end

  private

  def article
    @article ||= category.articles.find(params[:id])
  end
  helper_method :article

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
