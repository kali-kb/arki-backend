require 'rails_helper'

RSpec.describe "Feedbacks", type: :request do
  describe "GET /feedback_id:primary_key" do
    it "returns http success" do
      get "/feedback/feedback_id:primary_key"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /user:references" do
    it "returns http success" do
      get "/feedback/user:references"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /feedback_text:string" do
    it "returns http success" do
      get "/feedback/feedback_text:string"
      expect(response).to have_http_status(:success)
    end
  end

end
