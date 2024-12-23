#!/usr/bin/env ruby

# USAGE
# ruby examples/distance.rb "D:S299" "Y:1SII"
#   D:S299 --> Y:1SII: 885.623 ly

# use the local version of the code instead of a globally installed gem
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "json"
require "frontier"

include Frontier

if __FILE__ == $0

  # Make the universe available in these varaibles
  ALL_STARS = {}

  # Read star data (locally or from API)
  stars_closed_alpha = File.read "./fixtures/stars_closed_alpha.json"
  stars_closed_alpha = JSON.parse stars_closed_alpha

  # Create all star system objects with coordinates
  stars_closed_alpha.each do |star|
    key = star[0]
    value = star[1]
    location = Coords.new value["location"]["x"], value["location"]["y"], value["location"]["z"]
    star = Star.new key, value["solarSystemName"], location
    ALL_STARS[star.name] = star
  end

  # Direct distance between argument 1 and 2
  direct_distance = ALL_STARS[ARGV[0]].distance_ly(ALL_STARS[ARGV[1]])
  pp "#{ARGV[0]} --> #{ARGV[1]}: #{"%.3f" % direct_distance} ly"
end
