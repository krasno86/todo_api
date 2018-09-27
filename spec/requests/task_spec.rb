require 'rails_helper'

RSpec.describe Task, type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:task)  { create(:task, project: project) }

  describe '/api/v1/projects/:project_id/tasks' do
    context 'unauthorized user' do
      before { get "/api/v1/projects/#{:project_id}/tasks" }
      it { expect(response).to have_http_status 401 }
    end

    context 'authorized user to index' do
      before {
        5.times {create(:task, project: project) }
        get "/api/v1/projects/#{project.id}/tasks", headers: user.create_new_auth_token
      }
      it { expect(response).to have_http_status 200 }
      it 'show task' do
        expect(json['data'].length).to eq 5
        expect(json['data'][0]['attributes'].keys).to contain_exactly(*%w[name text])
      end
    end

    context 'get show' do
      before {
        get "/api/v1/projects/#{project.id}/tasks/#{task.id}",
             headers: user.create_new_auth_token
      }
      it { expect(response).to have_http_status 200 }
      it 'show task' do
        expect(response[:task])
      end
    end

    context 'create' do
      before {
        post "/api/v1/projects/#{project.id}/tasks",
             params: {
                      task:
                          {name: Faker::StarWars.droid,
                           text: Faker::StarWars.quote}
                      },
                      headers: user.create_new_auth_token
      }
      it { expect(response).to have_http_status 201 }
    end

    context 'DELETE' do
      before {
        delete "/api/v1/projects/#{project.id}/tasks/#{task.id}",
               params: { id: task.id }, headers: user.create_new_auth_token
      }
      it { expect(response).to have_http_status 204 }
    end

    context 'update' do
      before {
        put "/api/v1/projects/#{project.id}/tasks/#{task.id}",
            params: {task: {name: Faker::StarWars.droid} }, headers: user.create_new_auth_token
      }
      it { expect(response).to have_http_status 200 }
    end
  end
end
