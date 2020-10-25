# frozen_string_literal: true

class Importer::UserImporterService < ApplicationService
  BATCH_SIZE = 500
  def initialize(file_path:)
    @file_path = file_path
  end

  def call
    raise StandardError, "File does not exist" unless File.exist?(file_path)
    return if User.any?

    import
  end

  private

    attr_reader :file_path

    def import
      User.transaction do
        file.lazy.each_slice(BATCH_SIZE) do |lines|
          bulk_insert(lines.map { |line| record(line) })
        end
      end
    end

    def file
      @file ||= File.open(file_path, "r")
    end

    # rubocop:disable Rails/SkipsModelValidations
    def bulk_insert(records)
      User.insert_all(records, unique_by: :index_users_on_user_id)
    end
    # rubocop:enable Rails/SkipsModelValidations

    def record(line)
      json_record = Oj.load(line, symbol_keys: true)

      {
        name: json_record[:name],
        user_id: json_record[:user_id],
        lonlat: "POINT(#{json_record[:longitude]} #{json_record[:latitude]})",
        **timestamps,
      }
    end

    def timestamps
      { created_at: Time.zone.now, updated_at: Time.zone.now }
    end
end
