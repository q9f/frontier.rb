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
  prog = 0
  while c_id < LAST_STAR_ID
    id = c_id.to_s
    location = Coords.new stars_phase5[id]["location"]["x"], stars_phase5[id]["location"]["y"], stars_phase5[id]["location"]["z"]
    star = Star.new id, mapping_closed_alpha[id], location
    ALL_STARS << star
    c_id += 1
    prog += 1
    perc = prog.to_f / ALL_STARS.length.to_f * 100.0
    print "Mapping all star systems ... #{'%3.2f' % perc}%\r"
  end
  print "Mapping all star systems ...    done.\n"

  # Create a graph from all 23k stars (circa 5 million edges, time-consuming)
  # TODO: create graph-database
  prog = 0
  ALL_STARS.each do |a|
    ALL_STARS.each do |b|
      dist = a.distance_ly(b)
      if dist < MAX_JUMP_RANGE && dist > 0
        UNIVERSE_GRAPH.add_edge a.name, b.name, dist
      end
      prog += 1
      perc = prog.to_f / (ALL_STARS.length.to_f * ALL_STARS.length.to_f) * 100.0
      print "Building universe graph ... #{'%3.2f' % perc}%\r"
    end
  end
  print "Building universe graph ...    done.\n"

  # Path from "D:S299" to "Y:1SII"
  best_smart_gate_path = UNIVERSE_GRAPH.shortest_path("D:S299", "Y:1SII")
  pp best_smart_gate_path
end
