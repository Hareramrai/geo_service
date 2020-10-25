# frozen_string_literal: true

require "rails_helper"

RSpec.describe Geo::UserFinderService do
  describe ".call" do
    include_context "sample user data with matching & missing range"

    it "returns the near by users in acending order of user_id" do
      result = described_class.call(filter_params: { longitude: longitude, latitude: latitude, range: range })

      expect(result).to eq([ernesto, nolan])
      expect(result).not_to eq([nolan, ernesto]) # order of user_id matter's
    end
  end
end
