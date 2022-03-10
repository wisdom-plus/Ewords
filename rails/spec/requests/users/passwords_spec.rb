require 'rails_helper'

RSpec.describe "Passwords", type: :request do
  describe "GET /passwords" do
    it "リクエストが成功" do
      get new_user_password_path
      expect(response).to have_http_status(200)
    end
  end
end
