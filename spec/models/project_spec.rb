require 'rails_helper'

describe Project, type: :model do
  describe 'validations' do
    subject { build(:project) }

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'scopes' do
    describe '.not_private' do
      subject { Project.not_private }

      let(:public_project) { create(:project, is_public: true) }
      let(:private_project) { create(:project, is_public: false) }

      it 'includes public projects and excludes private ones' do
        expect(subject).to include(public_project)
        expect(subject).not_to include(private_project)
      end
    end

    describe '.all_for' do
      subject { Project.all_for(user) }

      let(:user) { create(:user) }

      let(:public_projects) { create_list(:project, 3, :not_private) }
      let(:private_projects) { create_list(:project, 3, is_public: false) }

      let(:public_project_of_user) { create(:project, :not_private, owner: user) }
      let(:private_project_of_user) { create(:project, is_public: false, owner: user) }

      it 'includes all projects visible for a user' do
        expect(subject).to include(*public_projects, public_project_of_user, private_project_of_user)
        expect(subject).not_to include(private_projects)
      end

      context 'when a user was added to a private project' do
        before { private_projects.first.users << user }

        it 'includes the project to visible' do
          expect(subject).to include(private_projects.first)
        end
      end
    end
  end
end
