require 'rails_helper'

describe CommentPolicy do
  subject { CommentPolicy.new(user, comment) }

  context 'being a visitor' do
    let(:comment) { build(:comment) }
    let(:user) { build(:user) }

    it { is_expected.to forbid_actions([:show, :destroy, :create]) }
  end

  context 'being an owner of comment' do
    let(:user) { create(:user) }
    let(:project) { create(:project, user: user) }
    let(:task)  { create(:task, project: project) }
    let(:comment)  { create(:comment, task: task, user: user) }

    it { is_expected.to permit_actions([:show, :destroy, :create]) }
  end
end
