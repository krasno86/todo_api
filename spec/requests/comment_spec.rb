require 'rails_helper'

RSpec.describe Comment, type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:task)  { create(:task, project: project) }
  let(:comment)  { create(:comment, task: task, user: user) }

  describe '/api/v1/projects/:project_id/tasks/:task_id/comments' do
    context 'unauthorized user' do
      before { get '/api/v1/projects' }
      it { expect(response).to have_http_status 401 }
    end

    context 'authorized user to index' do
      before {
        2.times {create(:comment, user: user, task: task)}
        get "/api/v1/projects/#{project.id}/tasks/#{task.id}/comments", headers: user.create_new_auth_token
      }
      it { expect(response).to have_http_status 200 }
      it 'show comments' do
        expect(json['data'].length).to eq 2
        expect(json['data'][0]['attributes'].keys).to contain_exactly(*%w[text file])
        expect(json['data'][0]).to match_response_schema("comment")
      end
    end

    context 'create' do
      before {
        post "/api/v1/projects/#{project.id}/tasks/#{task.id}/comments",
             params: {
                 comment:
                     {file: Faker::StarWars.droid,
                      text: Faker::StarWars.quote}
             },
             headers: user.create_new_auth_token
      }
      it { expect(response).to have_http_status 201 }
    end

    context 'DELETE comment' do
      before {
        delete "/api/v1/projects/#{project.id}/tasks/#{task.id}/comments/#{comment.id}",
               headers: user.create_new_auth_token
      }
      it { expect(response).to have_http_status 204 }
    end
  end
end
