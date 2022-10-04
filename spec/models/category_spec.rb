require 'rails_helper'

describe Category, type: :model do
  describe 'validations' do
    subject { build(:category) }

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    describe '.subcategories_cannot_have_children_categories' do
      let(:category_params) do
        {
          user: create(:user),
          project: create(:project)
        }
      end
      let(:parent_category) { create(:category, category_params) }
      let(:child_category) { create(:category, category_params.merge(parent: parent_category)) }

      context 'when a parent category has its own parent' do
        subject { build(:category, category_params.merge(parent: child_category)) }

        it 'is not valid' do
          expect(subject).not_to be_valid
          expect(subject.errors[:base]).to include('Subcategories cannot have children categories')
        end
      end

      context 'when a child category has children' do
        before do
          child_category
          parent_category.parent = create(:category, category_params)
        end

        it 'is not valid' do
          expect(parent_category).not_to be_valid
          expect(parent_category.errors[:base]).to include('Subcategories cannot have children categories')
        end
      end
    end
  end
end
