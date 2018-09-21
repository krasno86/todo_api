# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'model associations' do
    it { expect have_many(:comments) }
  end

  context 'db column' do
    it { expect have_db_column(:name).of_type(:string) }
    it { expect have_db_column(:text).of_type(:string) }
  end

  context 'basic validation presence_of' do
    it { expect validate_presence_of(:name) }
    it { expect validate_presence_of(:test) }
  end

  describe 'validation' do
    let(:invalid_task1) { build(:task, name: '') }
    let(:invalid_task2) { build(:task, name: 'regregeg', text: '') }

    it { expect(invalid_task1).not_to be_valid }
    it { expect(invalid_task2).not_to be_valid }
  end
end