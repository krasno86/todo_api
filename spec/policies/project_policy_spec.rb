require 'rails_helper'

describe ProjectPolicy do
  subject { described_class.new(user, project) }

  let(:project) { Project.create }

  context 'being a visitor' do
    let(:user) { create(:user) }

    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'being an admin' do
    let(:user) { build(:user, role: 'admin') }
    it { is_expected.to permit_actions([:destroy]) }
  end

  context 'being an owner of project' do

    let(:user1) { User.create }
    let(:project) { Project.create(user_id: user1.id) }

    it { is_expected.to permit_action([:show]) }
  end
end