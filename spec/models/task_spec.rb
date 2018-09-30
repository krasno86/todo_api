# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'model associations' do
    it { expect have_many(:comments) }
  end

  context 'db column' do
    it { expect have_db_column(:name).of_type(:string) }
  end

  context 'basic validation presence_of and uniq' do
    it { expect validate_presence_of(:name) }
    it { expect validate_uniqueness_of(:name) }
  end

  describe 'validation' do
    let(:user) { build(:user) }
    let(:project) { build(:project, user: user) }
    let(:task) { build(:task, project: project) }
    let(:invalid_task) { build(:task, name: '') }

    it { expect(task).to be_valid }
    it { expect(invalid_task).not_to be_valid }
  end
end