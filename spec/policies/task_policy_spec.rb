require 'rails_helper'

describe TaskPolicy do
  subject { TaskPolicy.new(user, task, project) }

  context 'being an owner of task' do
    let(:user) { create(:user) }
    let(:project) { create(:project, user: user) }
    let(:task)  { create(:task, project: project) }

    it { is_expected.to permit_actions([:index, :show, :update, :destroy, :create]) }
  end
end
