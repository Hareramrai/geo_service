# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::UsersController", type: :request do
  describe "GET /index" do
    include_context "sample user data with matching & missing range"

    context "when passing no params" do
      it "returns the user based on default params, which is berlin office and 100km range" do
        get api_users_url
        expect(json_response[:users]).to eq([
                                              { name: ernesto.name, user_id: ernesto.user_id },
                                              { name: nolan.name, user_id: nolan.user_id },
                                            ])
      end
    end

    context "when passing params which is out of range" do
      it "returns blank" do
        get api_users_url, params: { longitude: 77.713125, latitude: 12.937654, range: 200 }
        expect(json_response[:users]).to be_blank
      end
    end
  end
end
