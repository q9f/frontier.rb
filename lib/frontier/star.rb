# Copyright (c) 2024-25 Afri Schoedon (q9f)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Provides the {Frontier} module.
module Frontier

  # A star-system object from id, name, and location
  class Star

    # Light year in meters for conversion
    LIGHT_YEAR = 9_460_800_000_000_000

    # The numeric id of the star system (e.g., 30015043)
    attr_accessor :id

    # The name of the star system (e.g., D:S299)
    attr_accessor :name

    # The location of the star system `Frontier::Coords.{x,y,z}`
    attr_accessor :location

    # Create a star system object from id, name, and location
    def initialize(id, name, location)
      @id = id.to_i
      @name = name.to_s
      @location = Coords.new location.x, location.y, location.z
    end

    # Get's the distance to another star system in meters
    def distance_mt(star)
      dist_x = (@location.x - star.location.x) * (@location.x - star.location.x)
      dist_y = (@location.y - star.location.y) * (@location.y - star.location.y)
      dist_z = (@location.z - star.location.z) * (@location.z - star.location.z)
      dist = Math.sqrt(dist_x + dist_y + dist_z)
    end

    # Get's the distance to another star system in light years
    def distance_ly(star)
      dist = distance_mt star
      dist = dist / LIGHT_YEAR
    end
  end
end
