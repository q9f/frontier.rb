#!/usr/bin/env ruby

# use the local version of the code instead of a globally installed gem
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "json"
require "frontier"

include Frontier

if __FILE__ == $0

  # Star system IDs are offset by 30 million
  STAR_ID_OFFSET = 30_000_000

  # Amount of star systems in phase 5
  STAR_COUNT = 20_230
  LAST_STAR_ID = STAR_ID_OFFSET + STAR_COUNT

  # Make the universe available in these varaibles
  ALL_STARS = {}

  # Read star data (locally or from API)
  stars_phase5 = File.read "./spec/fixtures/stars_phase5.json"
  stars_phase5 = JSON.parse stars_phase5
  mapping_closed_alpha = File.read "./spec/fixtures/mapping_closed_alpha.json"
  mapping_closed_alpha = JSON.parse mapping_closed_alpha

  # Create all star system objects with coordinates
  c_id = STAR_ID_OFFSET + 1
  prog = 0
  while c_id < LAST_STAR_ID
    id = c_id.to_s
    location = Coords.new stars_phase5[id]["location"]["x"], stars_phase5[id]["location"]["y"], stars_phase5[id]["location"]["z"]
    star = Star.new id, mapping_closed_alpha[id], location
    ALL_STARS[star.name] = star
    c_id += 1
  end

  # Direct distance between "D:S299" to "Y:1SII"
  direct_distance = ALL_STARS["D:S299"].distance_ly(ALL_STARS["Y:1SII"])
  pp direct_distance
end
