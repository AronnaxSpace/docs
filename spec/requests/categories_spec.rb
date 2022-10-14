require 'rails_helper'

RSpec.describe '/projects/:id/categories', type: :request do
  let(:project) { create(:project) }
  let(:valid_attributes) do
    {
      name: Faker::Lorem.word
    }
  end
  let(:invalid_attributes) do
    {
      name: nil
    }
  end
  let(:category) { create(:category, valid_attributes.merge(project:)) }

  before do
    sign_in project.owner
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_project_category_url(project)

      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      get edit_project_category_url(project, category)

      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new category' do
        expect do
          post project_categories_url(project, format: :turbo_stream), params: { category: valid_attributes }
        end.to change(Category, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new category' do
        expect do
          post project_categories_url(project, format: :turbo_stream), params: { category: invalid_attributes }
        end.to change(Category, :count).by(0)

        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          name: Faker::Lorem.word
        }
      end

      it 'updates a category' do
        patch project_category_url(project, category, format: :turbo_stream), params: { category: new_attributes }

        expect(category.reload.name).to eq(new_attributes[:name])
      end
    end

    context 'with invalid parameters' do
      it 'does not update a category' do
        category_attributes = category.attributes
        patch project_category_url(project, category, format: :turbo_stream), params: { category: invalid_attributes }

        expect(response).to be_successful
        expect(category.reload.attributes).to eq(category_attributes)
      end
    end
  end

  describe 'DELETE /destroy' do
    before { category }

    it 'destroys a category' do
      expect do
        delete project_category_url(project, category, format: :turbo_stream)
      end.to change(Category, :count).by(-1)

      expect(response).to be_successful
    end
  end
end
