require 'rails_helper'

RSpec.describe 'sign_in and sign_out', type: :request do
  let(:user) { create(:user) }
  describe 'GET /api/v1/projects' do
    context 'invalid username' do
      before {
        post '/auth/sign_in',
             params: {
                 username: 'test@example.com',
                 password: user.password,
                 uid: user.uid
             }
      }

      it { expect(response).to have_http_status 401 }
    end

    context 'sign_in' do
      before {
        post '/auth/sign_in',
             params: {
                 username: user.username,
                 password: '12345678'
             }
      }

      it 'valid params' do
        p response.body
        expect(response).to have_http_status 200

      end
    end
  end
end

