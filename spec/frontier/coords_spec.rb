# -*- encoding : ascii-8bit -*-

require "spec_helper"

describe Coords do
  let(:stars_phase5_file) { File.read "spec/fixtures/stars_phase5.json" }
  subject(:stars_phase5) { JSON.parse stars_phase5_file }

  it "can map basic coordinates" do
    base = Coords.new(0,0,0)
    expect(base.x).to eq 0
    expect(base.y).to eq 0
    expect(base.z).to eq 0
  end

  it "can map frontier coordinates" do
    star = Coords.new stars_phase5["30000001"]["location"]["x"], stars_phase5["30000001"]["location"]["y"], stars_phase5["30000001"]["location"]["z"]
    expect(star.x).to eq -4904707237374110000
    expect(star.y).to eq -332297545060131000
    expect(star.z).to eq 122856493430790000
  end
end
