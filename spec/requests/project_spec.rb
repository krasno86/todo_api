require 'rails_helper'

RSpec.describe Project, type: :request do
  let(:user) { create(:user) }
  let(:project)  { create(:project, user: user) }

  describe '/api/v1/projects' do
    context 'unauthorized user to index' do
      before { get '/api/v1/projects' }
      it { expect(response).to have_http_status 401 }
    end

    context 'authorized user to index' do
      before {
        2.times {create(:project, user: user)}
        get "/api/v1/projects", headers: user.create_new_auth_token
      }
      it { expect(response).to have_http_status 200 }
      it 'show all projects' do
        # p JSON.pretty_generate(json)
        expect(json['data'].length).to eq 2
        expect(json['data'][0]['attributes'].keys).to contain_exactly(*%w[name])
      end
    end

    context 'authorized user to show' do
      before {
        get "/api/v1/projects/#{project.id}",
            params: { id: project.id }, headers: user.create_new_auth_token
      }
      it { expect(response).to have_http_status 200 }
      it 'show project' do
        expect(json).to match_response_schema("project")
      end
    end

    context 'authorized user to create' do
      before {
        post '/api/v1/projects',
             params: {project: {name: Faker::StarWars.droid} }, headers: user.create_new_auth_token
      }
      it { expect(response).to have_http_status 201 }
    end

    context 'authorized user to DELETE' do
      before {
        delete "/api/v1/projects/#{project.id}",
             headers: user.create_new_auth_token
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
