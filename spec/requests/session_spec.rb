require 'rails_helper'

RSpec.describe 'sign_in and sign_out', type: :request do
  let(:user) { create(:user) }
  describe 'GET /api/v1/projects' do
    context 'ivalid username' do
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

    context 'when user has confirmed email' do
      before {
        post '/auth/sign_in',
             params: {
                 username: user.username,
                 password: '12345678'
             }
      }

      it 'w34frwefer' do
        p response.body
        expect(response).to have_http_status 200

      end
    end
  end
end

