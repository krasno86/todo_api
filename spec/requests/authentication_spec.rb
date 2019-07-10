require 'rails_helper'

RSpec.describe 'sign_up ', type: :request do
  let(:user) { create(:user) }

  describe 'GET /auth' do
    context 'ivalid password lenght' do
      before {
        post '/auth',
             params: {
                 email: 'test@example.com',
                 password: 'swgfw',
                 password_confirmation: 'swgfw',
                 uid: 'wf4f3f34'
             }
      }
      it { expect(response).to have_http_status 422 }
    end

    context 'with valid params' do
      before {
        post '/auth',
             params: {
                 email: 'test@example.com',
                 password: '12345678',
                 password_confirmation: '12345678',
                 uid: 'dy45ry4'
             }
      }
      it 'status 200 and valid user' do
        expect(response).to have_http_status 200
        expect(json['data']).to match_response_schema("user")
      end
    end
  end

  context 'registrations#destroy' do
    before { delete '/auth', headers: user.create_new_auth_token }
    it { expect(response).to have_http_status 200 }
  end
end
