require 'rails_helper'

RSpec.describe 'sign_up ', type: :request do
  describe 'GET /auth' do
    context 'ivalid password lenght' do
      before {
        post '/auth',
             params: {
                 email: 'test@example.com',
                 username: 'jlklkjn',
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
                 email: 'egeg@sg.com',
                 username: 'jlklkjn',
                 password: '12345678',
                 password_confirmation: '12345678',
                 uid: 'dy45ry4'
             }
      }

      it { expect(response).to have_http_status 200 }
    end
    context 'with blank email' do
      before {
        post '/auth',
             params: {
                 email: '',
                 username: 'jlklkjn',
                 password: '12345678',
                 password_confirmation: '12345678',
                 uid: 'dy45ry4'
             }
      }

      it { expect(response).to have_http_status 422 }
    end
  end
end
