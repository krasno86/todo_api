require 'rails_helper'

describe ProjectPolicy do
  subject { ProjectPolicy.new(user, project) }

  context 'being a visitor' do
    let(:project) { build(:project) }
    let(:user) { build(:user) }

    it { is_expected.to forbid_actions([:show, :update, :destroy, :create]) }
  end

  context 'being an admin' do
    let(:user) { build(:user, role: 'admin') }
    let(:project) { build(:project) }

    it { is_expected.to permit_actions([:destroy]) }
  end

  context 'being an owner of project' do
    let(:user) { create(:user) }
    let(:project) { create(:project, user_id: user.id) }

    it { is_expected.to permit_actions([:show, :update, :destroy, :create]) }
  end
end
