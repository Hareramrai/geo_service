# frozen_string_literal: true

class User < ApplicationRecord
  scope :nearby, ->(latitude, longitude, range_in_km = 1) {
    where(format(%{
     ST_Distance(lonlat, 'POINT(%f %f)') < %d
    }, longitude, latitude, range_in_km * 1000))
  }
end
