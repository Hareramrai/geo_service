# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  include_context "sample user data with matching & missing range"

  describe ".nearby" do
    context "when users are in nearby" do
      it "returns the user who are in range of give lon & lat" do
        expect(User.nearby(latitude, longitude, range)).to eq([ernesto, nolan])
      end
    end

    context "when users are not in nearby" do
      it "returns blank" do
        expect(User.nearby(latitude, longitude, 0.5)).to be_blank
      end
    end
  end
end
