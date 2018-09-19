require "rails_helper"
include ActionController::RespondWith

RSpec.describe Api::V1::ProjectsController, :type => :controller do
  let!(:user) { FactoryBot.create(:user) }
  describe "GET index" do
    it "has a 401 status code" do
      get :index
      expect(response.status).to eq(401)
    end
  end

  # it "has a 200 status code" do
  #   get :index
  #   expect(response.status).to eq(200)
  # end
end