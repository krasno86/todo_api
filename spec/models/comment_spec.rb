# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'db column' do
    it { expect have_db_column(:file).of_type(:string) }
    it { expect have_db_column(:text).of_type(:string) }
  end

  context 'basic validation presence_of' do
    it { expect validate_presence_of(:file) }
    it { expect validate_presence_of(:text) }
  end

  describe 'validation' do
    let(:user) { build(:user) }
    let(:project) { build(:project, user: user) }
    let(:task) { build(:task, project: project) }
    let(:valid_comment) { create(:comment, user: user, task: task) }
    let(:invalid_comment1) { build(:comment, text: '') }
    let(:invalid_comment) { build(:comment, text: 'bla bla') }

    it { expect(valid_comment).to be_valid }
    it { expect(invalid_comment1).not_to be_valid }
    it { expect(invalid_comment1).not_to be_valid }
  end

  context "#to_json" do
    let(:user) { create(:user) }
    let(:project) { create(:project, user: user) }
    let(:task)  { create(:task, project: project) }
    let(:comment)  { create(:comment, text: 'bla bla erqvevqev', task: task, user: user) }


    it "includes name" do
      text = %({"text":"bla bla erqvevqev","file":{"url": null}})
      expect(comment.to_json).to be_json_eql(text).excluding("task_id", "user_id")
    end

    it "includes the ID" do
      expect(comment.to_json).to have_json_path("id")
      expect(comment.to_json).to have_json_type(Integer).at_path("id")
    end
  end
end