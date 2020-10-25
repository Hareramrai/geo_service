# frozen_string_literal: true

Importer::UserImporterService.call(file_path: Rails.root.join("db/data/users.json"))
