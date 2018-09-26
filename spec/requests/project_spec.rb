require 'rails_helper'

RSpec.describe Project, type: :request do
  let(:user) { create(:user) }
  let(:project)  { create(:project, user: user) }
  let(:projects)  { create(project, 5) }

  describe '/api/v1/projects' do
    context 'unauthorized user' do
      before { get '/api/v1/projects' }
      it { expect(response).to have_http_status 401 }
    end

    context 'authorized user to index' do
      let(:projects) { create_list(project, 5)  }
      before {
        get "/api/v1/projects", headers: user.create_new_auth_token
      }
      it { expect(response).to have_http_status 200 }
      it 'show all projects' do
        expect(json_response[:projects].size).to eq(5)
        expect(response[:project])
      end
    end

    context 'authorized user to show' do
      before {
        get "/api/v1/projects/#{project.id}",
            params: { id: project.id }, headers: user.create_new_auth_token
      }
      it { expect(response).to have_http_status 200 }
      it 'show project' do
        p JSON.pretty_generate(json)
        expect(response[:project])
      end
    end

    context 'create' do
      before {
        post '/api/v1/projects',
             params: {project: {name: Faker::StarWars.droid} }, headers: user.create_new_auth_token
      }
      it { expect(response).to have_http_status 201 }
    end

    context 'DELETE' do
      let(:user1) { create(:user, email: 'wgt3wgf@dgd.com') }
      before {
        delete "/api/v1/projects/#{project.id}",
             params: { id: project.id }, headers: user1.create_new_auth_token
      }
      it { expect(response).to have_http_status 204 }
    end

    context 'PUT /api/v1/projects/:id' do
      before {
        put "/api/v1/projects/#{project.id}",
               params: {project: {name: Faker::StarWars.droid} }, headers: user.create_new_auth_token
      }
      it { expect(response).to have_http_status 200 }
    end
  end
end
