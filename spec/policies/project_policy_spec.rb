require 'rails_helper'

describe ProjectPolicy do
  subject { ProjectPolicy.new(user, project) }

  context 'being a visitor' do
    let(:project) { Project.create }
    let(:user) { create(:user) }

    it { is_expected.to forbid_actions([:show, :index, :update, :destroy, :create]) }
  end

  context 'being an admin' do
    let(:user) { build(:user, role: 'admin') }
    let(:project) { Project.create }

    it { is_expected.to permit_actions([:destroy]) }
  end

  context 'being an owner of project' do
    let(:user) { create(:user) }
    let(:project) { create(:project, user_id: user.id) }

    it { is_expected.to permit_actions([:show, :index, :update, :destroy, :create]) }
  end
end
