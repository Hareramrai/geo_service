# frozen_string_literal: true

class Api::UsersController < ApplicationController
  # GET /users?latitude=&longitude=&range
  def index
    @users = Geo::UserFinderService.call(filter_params: filter_params)
  end

  private

    def filter_params
      params.permit(:longitude, :latitude, :range)
    end
end
