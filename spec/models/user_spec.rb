# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'model associations' do
    it { expect have_many(:projects) }
    it { expect have_many(:comments) }
  end

  context 'db column' do
    it { expect have_db_column(:username).of_type(:string) }
    it { expect have_db_column(:uid).of_type(:string) }
  end

  context 'basic validation presence_of' do
    it { expect validate_presence_of(:username) }
  end

  context 'basic validation uniques' do
    it { expect validate_uniqueness_of(:username) }
  end

  describe 'validation' do
    let(:user)         { build(:user) }
    let(:invalid_user) { build(:user, email: 'sd') }

    it { expect(user).to be_valid }
    it { expect(invalid_user).not_to be_valid }
  end

  context 'set default role' do
    let(:user){ build(:user) }

    it { expect(user.role).to eq('user') }
  end
end