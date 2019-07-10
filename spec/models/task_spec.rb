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
    let(:task) { build(:task, name: 'bla bla', project: project) }
    let(:invalid_task) { build(:task, name: '') }

    it { expect(task).to be_valid }
    it { expect(invalid_task).not_to be_valid }
  end

  context "#to_json" do
    let(:user)    { create(:user) }
    let(:project) { create(:project, user: user) }
    let(:task) { create(:task, name: 'bla bla', project: project) }

    it "includes name" do
      task_params = %({"name":"bla bla", "completed": false, "deadline": null})
      expect(task.to_json).to be_json_eql(task_params).excluding("project_id")
    end

    it "includes the ID" do
      expect(task.to_json).to have_json_path("id")
      expect(task.to_json).to have_json_type(Integer).at_path("id")
    end
  end
end