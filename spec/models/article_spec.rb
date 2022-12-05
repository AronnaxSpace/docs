require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'validations' do
    subject { build(:article) }

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end
  end
end
