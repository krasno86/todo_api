# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  context 'model associations' do
    it { expect have_many(:tasks) }
  end

  context 'db column' do
    it { expect have_db_column(:name).of_type(:string) }
  end

  context 'basic validation presence_of' do
    it { expect validate_presence_of(:name) }
  end

  describe 'validation' do
    let(:user) { build(:user) }
    let(:project) { build(:project, user: user) }
    let(:invalid_project) { build(:project, name: '') }

    it do 'with valid params'
      expect(project).to be_valid
    end
    it do 'with blank name'
      expect(invalid_project).not_to be_valid
    end
  end
end