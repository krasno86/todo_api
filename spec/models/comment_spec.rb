# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'db column' do
    it { expect have_db_column(:file).of_type(:string) }
    it { expect have_db_column(:text).of_type(:string) }
  end

  context 'basic validation presence_of' do
    it { expect validate_presence_of(:file) }
    it { expect validate_presence_of(:test) }
  end

  describe 'validation' do
    let(:user) { build(:user) }
    let(:project) { build(:project, user: user) }
    let(:valid_comment) { build(:comment, user: user, project: project) }
    let(:invalid_comment1) { build(:comment, text: '') }
    let(:invalid_comment) { build(:comment, text: 'bla bla') }

    it { expect(valid_comment).to be_valid }
    it { expect(invalid_comment1).not_to be_valid }
    it { expect(invalid_comment1).not_to be_valid }
  end
end