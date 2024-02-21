# spec/requests/api/microposts_spec.rb
require 'rails_helper'

RSpec.describe "Microposts", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:headers) { { "ACCEPT" => "application/json" } }

  before do
    sign_in user
  end

  describe "GET /microposts" do
    it "returns a success response" do
      get "/api/microposts", headers: headers
      expect(response).to be_successful
    end
  end

  describe "POST /microposts" do
    it "creates a new Micropost" do
      post "/api/microposts", params: { micropost: { content: "Hello, world!" } }, headers: headers
      expect(response).to have_http_status(:ok)
    end
  end

  # Other tests for show, update, destroy actions
end
