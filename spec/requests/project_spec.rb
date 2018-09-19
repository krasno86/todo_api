require 'rails_helper'

RSpec.describe Project, type: :request do
  let(:user) { create(:user) }

  describe 'GET /api/v1/projects' do
    context 'unauthorized user' do
      before { get '/api/v1/projects' }
      it { expect(response).to have_http_status 401 }
    end

    context 'authorized user' do
      before { get '/api/v1/projects', headers: user.create_new_auth_token }
      it { expect(response).to have_http_status 200 }
      it 'show projects' do
        expect(response[:project])
      end
    end
  end
end
