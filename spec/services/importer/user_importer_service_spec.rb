# frozen_string_literal: true

require "rails_helper"

RSpec.describe Importer::UserImporterService do
  describe ".call" do
    context "when file exists" do
      let(:file_path) { Rails.root.join("db/data/users.json") }

      it "imports all lines from the given file" do
        expect { described_class.call(file_path: file_path) }.to change { User.count }.by(50)
      end
    end

    context "when file doesn't exist" do
      let(:file_path) { Rails.root.join("db/data/nofile.json") }

      it "raise file doesn't exist exception" do
        expect { described_class.call(file_path: file_path) }.to raise_error(StandardError, /File does not exist/)
      end
    end
  end
end
