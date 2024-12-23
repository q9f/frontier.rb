#!/usr/bin/env ruby

# USAGE
# ruby examples/pathfinder.rb "D:S299" "Y:1SII"
#   Mapping all star systems ...    done.
#   Building universe graph ...    done.
#   D:S299 --> Y:1SII: 885.623 ly(D:S299 --> G.QXJ.4SH --> P:S696 --> Q:1A97 --> J:3K85 --> Y:1SII)

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
  ALL_STARS = {}
  UNIVERSE_GRAPH = Graph.new

  # Read star data (locally or from API)
  stars_closed_alpha = File.read "./spec/fixtures/stars_closed_alpha.json"
  stars_closed_alpha = JSON.parse stars_closed_alpha

  # Create all star system objects with coordinates
  prog = 0
  stars_closed_alpha.each do |star|
    key = star[0]
    value = star[1]
    location = Coords.new value["location"]["x"], value["location"]["y"], value["location"]["z"]
    star = Star.new key, value["solarSystemName"], location
    ALL_STARS[star.name] = star
    prog += 1
    perc = prog.to_f / ALL_STARS.length.to_f * 100.0
    print "Mapping all star systems ... #{"%3.2f" % perc}%\r"
  end
  print "Mapping all star systems ...    done.\n"

  # Create a graph from all 23k stars (circa 5 million edges, time-consuming)
  # TODO: create graph-database
  prog = 0
  ALL_STARS.each do |a|
    ALL_STARS.each do |b|
      dist = a[1].distance_ly(b[1])
      if dist < MAX_JUMP_RANGE && dist > 0
        UNIVERSE_GRAPH.add_edge a[1].name, b[1].name, dist
      end
      prog += 1
      perc = prog.to_f / (ALL_STARS.length.to_f * ALL_STARS.length.to_f) * 100.0
      print "Building universe graph ... #{"%3.2f" % perc}%\r"
    end
  end
  print "Building universe graph ...    done.\n"

  # Path from argument 1 and 2
  best_smart_gate_path = UNIVERSE_GRAPH.shortest_path(ARGV[0], ARGV[1])
  pp "#{ARGV[0]} --> #{ARGV[1]}: #{"%.3f" % best_smart_gate_path["dist"]} ly (#{best_smart_gate_path["path"].join(" --> ")})"
end
