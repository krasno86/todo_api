require 'rails_helper'

RSpec.describe 'sign_up ', type: :request do
  describe 'GET /auth' do
    # context 'ivalid password lenght' do
    #   before {
    #     post '/auth',
    #          params: {
    #              username: 'test@example.com',
    #              password: 'swgfw',
    #              password_confirmation: 'swgfw',
    #              uid: 'wf4f3f34'
    #          }
    #   }
    #
    #   it { expect(response).to have_http_status 401 }
    # end

    context 'with valid params' do
      before {
        post '/auth',
             params: {
                 username: 'jlklkjn',
                 password: '12345678',
                 password_confirmation: '12345678',
                 uid: 'dy45ry4'
             }
      }

      it 'w34frwefer' do
        p response.body
        expect(response).to have_http_status 200
      end
    end
  end
end
