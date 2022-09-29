require 'rails_helper'

RSpec.describe '/projects', type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) do
    {
      name: Faker::Lorem.sentence,
      owner: user
    }
  end
  let(:invalid_attributes) do
    {
      name: nil,
      owner: user
    }
  end
  let(:project) { create(:project, valid_attributes) }

  before do
    sign_in user
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get projects_url

      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get project_url(project)

      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_project_url

      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      project = Project.create! valid_attributes
      get edit_project_url(project)

      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new project and redirects to it' do
        expect do
          post projects_url, params: { project: valid_attributes }
        end.to change(Project, :count).by(1)

        expect(response).to redirect_to(project_url(Project.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new project' do
        expect do
          post projects_url, params: { project: invalid_attributes }
        end.to change(Project, :count).by(0)

        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          name: Faker::Lorem.sentence,
          description: Faker::Lorem.paragraph
        }
      end

      it 'updates the requested project and redirects to it' do
        patch project_url(project), params: { project: new_attributes }

        expect(response).to redirect_to(project_url(project))

        project.reload

        expect(project.name).to eq(new_attributes[:name])
        expect(project.description).to eq(new_attributes[:description])
      end
    end

    context 'with invalid parameters' do
      it 'does not update a project' do
        project_attributes = project.attributes
        patch project_url(project), params: { project: invalid_attributes }

        expect(response).to have_http_status(422)
        expect(project.reload.attributes).to eq(project_attributes)
      end
    end
  end

  describe 'DELETE /destroy' do
    before { project }

    it 'destroys the requested project and redirects to the projects list' do
      expect do
        delete project_url(project)
      end.to change(Project, :count).by(-1)

      expect(response).to redirect_to(projects_url)
    end
  end
end
