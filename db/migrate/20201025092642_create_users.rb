# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.st_point :lonlat, geographic: true, index: { using: :gist }
      t.bigint :user_id, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
