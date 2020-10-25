# frozen_string_literal: true

class Geo::UserFinderService < ApplicationService
  DEFAULT_RANGE = 100
  DEFAULT_LONGITUDE = 13.329657
  DEFAULT_LATITUDE = 52.508283

  def initialize(filter_params:)
    @filter_params = filter_params
  end

  def call
    User.nearby(latitude, longitude, range).order(user_id: :asc)
  end

  private

    attr_reader :filter_params

    def longitude
      filter_params[:longitude] || DEFAULT_LONGITUDE
    end

    def latitude
      filter_params[:latitude] || DEFAULT_LATITUDE
    end

    def range
      (filter_params[:range] || DEFAULT_RANGE).to_f
    end
end
