# -*- encoding : ascii-8bit -*-

require "spec_helper"

describe Star do
  let(:stars_phase5_file) { File.read "./fixtures/stars_phase5.json" }
  subject(:stars_phase5) { JSON.parse stars_phase5_file }
  let(:stars_closed_alpha_file) { File.read "./fixtures/stars_closed_alpha.json" }
  subject(:stars_closed_alpha) { JSON.parse stars_closed_alpha_file }
  let(:mapping_closed_alpha_file) { File.read "./fixtures/mapping_closed_alpha.json" }
  subject(:mapping_closed_alpha) { JSON.parse mapping_closed_alpha_file }

  it "can create a generic star system" do
    loc = Coords.new(0, 0, 0)
    sun = Star.new(1, "Sun", loc)
    expect(sun.id).to eq 1
    expect(sun.name).to eq "Sun"
    expect(sun.location.x).to eq 0
    expect(sun.location.y).to eq 0
    expect(sun.location.z).to eq 0
  end

  it "knows light years" do
    expect(Star::LIGHT_YEAR).to eq 9460800000000000
  end

  context "phase 5" do
    it "can create frontier star systems" do
      id = "30000001"
      loc = Coords.new stars_phase5[id]["location"]["x"], stars_phase5[id]["location"]["y"], stars_phase5[id]["location"]["z"]
      a2560 = Star.new(id, mapping_closed_alpha[id], loc)
      expect(a2560.id).to eq 30000001
      expect(a2560.name).to eq "A 2560"
      expect(a2560.location.x).to eq -4904707237374110000
      expect(a2560.location.y).to eq -332297545060131000
      expect(a2560.location.z).to eq 122856493430790000
    end

    it "can compute distance between two stars" do
      loc = Coords.new(0, 0, 0)
      sun = Star.new(1, "Sun", loc)
      id = "30000001"
      loc = Coords.new stars_phase5[id]["location"]["x"], stars_phase5[id]["location"]["y"], stars_phase5[id]["location"]["z"]
      a2560 = Star.new(id, mapping_closed_alpha[id], loc)
      expect(sun.distance_mt(a2560)).to eq 4917485989891691520
      expect(sun.distance_ly(a2560)).to eq 519.7748594084741
    end
  end

  context "closed alpha (phase 6)" do
    it "can create frontier star systems" do
      id = "30000001"
      loc = Coords.new stars_closed_alpha[id]["location"]["x"], stars_closed_alpha[id]["location"]["y"], stars_closed_alpha[id]["location"]["z"]
      a2560 = Star.new(id, stars_closed_alpha[id]["solarSystemName"], loc)
      expect(a2560.id).to eq 30000001
      expect(a2560.name).to eq "A 2560"
      expect(a2560.location.x).to eq -3350000000000000000
      expect(a2560.location.y).to eq -510000000000000000
      expect(a2560.location.z).to eq 396000000000000000
    end

    it "can compute distance between two stars" do
      loc = Coords.new(0, 0, 0)
      sun = Star.new(1, "Sun", loc)
      id = "30000001"
      loc = Coords.new stars_closed_alpha[id]["location"]["x"], stars_closed_alpha[id]["location"]["y"], stars_closed_alpha[id]["location"]["z"]
      a2560 = Star.new(id, stars_closed_alpha[id]["solarSystemName"], loc)
      expect(sun.distance_mt(a2560)).to eq 3411658834057121792
      expect(sun.distance_ly(a2560)).to eq 360.6099731584139
    end
  end
end
