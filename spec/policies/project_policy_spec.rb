require 'rails_helper'

describe ProjectPolicy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:project) { build(:project) }

  permissions :show? do
    context 'when a project is public' do
      before { project.is_public = true }

      it 'grants access' do
        expect(subject).to permit(user, project)
      end
    end

    context 'when a project is owned by a user' do
      before { project.owner = user }

      it 'grants access' do
        expect(subject).to permit(user, project)
      end
    end

    context 'when a user was added to a project' do
      before { project.users << user }

      it 'grants access' do
        expect(subject).to permit(user, project)
      end
    end

    context 'when a project is not public and does not belong to a user' do
      before { project.owner = create(:user) }

      it 'denies access' do
        expect(subject).not_to permit(user, project)
      end
    end
  end

  permissions :destroy?, :update?, :edit? do
    context 'when a project belongs to a user' do
      before { project.owner = user }

      it 'grants access' do
        expect(subject).to permit(user, project)
      end
    end

    context 'when a project does not belong to a user' do
      before { project.is_public = true }

      it 'denies access' do
        expect(subject).not_to permit(user, project)
      end
    end
  end
end
