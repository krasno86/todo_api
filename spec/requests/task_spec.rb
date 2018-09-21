require 'rails_helper'

RSpec.describe Task, type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:task)  { create(:task, project: project) }

  describe '/api/v1/projects' do
    context 'unauthorized user' do
      before { get '/api/v1/projects' }
      it { expect(response).to have_http_status 401 }
    end

    context 'authorized user to index' do
      before { get "/api/v1/projects/#{project.id}/tasks/#{task.id}", headers: user.create_new_auth_token }
      it { expect(response).to have_http_status 200 }
      it 'show task' do
        p task
        expect(response[:task])
      end
    end

    context 'get /api/v1/tasks/:id' do
      before {
        get "/api/v1/projects/#{project.id}/tasks/#{task.id}",
            params: { id: project.id }, headers: user.create_new_auth_token
      }
      it { expect(response).to have_http_status 200 }
      it 'show project' do
        expect(response[:project])
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

    context 'DELETE tasks' do
      before {
        delete "/api/v1/projects/#{project.id}/tasks/#{task.id}",
               params: { id: task.id }, headers: user.create_new_auth_token
      }
      it { expect(response).to have_http_status 204 }
    end

    context 'update task' do
      before {
        put "/api/v1/projects/#{project.id}/tasks/#{task.id}",
            params: {project: {name: Faker::StarWars.droid} }, headers: user.create_new_auth_token
      }
      it { expect(response).to have_http_status 200 }
    end
  end
end
