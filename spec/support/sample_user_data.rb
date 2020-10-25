# frozen_string_literal: true

RSpec.shared_context "sample user data with matching & missing range" do
  let(:longitude) { 13.329657 }
  let(:latitude) { 52.508283 }
  let(:range) { 100 }

  # users in range of lat & long
  let!(:ernesto) { create(:user, name: "Ernesto Breitenberg", lonlat: "POINT (13.067312769068188 52.94260786195436)", user_id: 4) }
  let!(:nolan) { create(:user, name: "Nolan Little", lonlat: "POINT (13.543372863802071 52.16209823311126)", user_id: 6) }

  # users not in range of lat & long
  let!(:mary) { create(:user, name: "Mary Pacocha III", lonlat: "POINT (15.175624975930294 54.0653745433511)", user_id: 3) }
  let!(:antoine) { create(:user, name: "Prof. Antoine Sporer", lonlat: "POINT (15.027900973331768 51.421974275443155)", user_id: 16) }
end
