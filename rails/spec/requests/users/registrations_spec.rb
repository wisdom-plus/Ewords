require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  describe "GET /registrations" do
    it "リクエストが成功" do
      get new_user_registration_path
      expect(response).to have_http_status(200)
    end
  end
end
