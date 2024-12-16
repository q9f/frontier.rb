#!/usr/bin/env ruby

# use the local version of the code instead of a globally installed gem
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "json"
require "frontier"

include Frontier

if __FILE__ == $0

  # Smart Gate maximum jump range
  MAX_JUMP_RANGE = 500 # ly

  # Star system IDs are offset by 30 million
  STAR_ID_OFFSET = 30_000_000

  # Amount of star systems in phase 5
  STAR_COUNT = 20_230
  LAST_STAR_ID = STAR_ID_OFFSET + STAR_COUNT

  # Make the universe available in these varaibles
  ALL_STARS = []
  UNIVERSE_GRAPH = Graph.new

  # Read star data (locally or from API)
  stars_phase5 = File.read "./spec/fixtures/stars_phase5.json"
  stars_phase5 = JSON.parse stars_phase5
  mapping_closed_alpha = File.read "./spec/fixtures/mapping_closed_alpha.json"
  mapping_closed_alpha = JSON.parse mapping_closed_alpha

  # Create all star system objects with coordinates
  c_id = STAR_ID_OFFSET + 1
  while c_id < LAST_STAR_ID
    id = c_id.to_s
    location = Coords.new stars_phase5[id]["location"]["x"], stars_phase5[id]["location"]["y"], stars_phase5[id]["location"]["z"]
    star = Star.new id, mapping_closed_alpha[id], location
    ALL_STARS << star
    c_id += 1
  end

  # Create a graph from all 23k stars (circa 5 million edges, time-consuming)
  # TODO: create graph-database
  ALL_STARS.each do |a|
    ALL_STARS.each do |b|
      dist = a.distance_ly(b)
      if dist < MAX_JUMP_RANGE && dist > 0
        UNIVERSE_GRAPH.add_edge a.name, b.name, dist
      end
    end
  end

  # Path from "E.2HM.2RR" to "I.EXP.NJ7"
  best_smart_gate_path = UNIVERSE_GRAPH.shortest_path("E.2HM.2RR", "I.EXP.NJ7")
  pp best_smart_gate_path
end
