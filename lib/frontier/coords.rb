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

  # Provides {Coords} coordinates in a 3-dimensional space
  class Coords

    # Coordinates of x, y, z in meters of the coordination system
    attr_accessor :x, :y, :z

    # Creates an coordinate triple from x, y, z
    def initialize(x, y, z)
      @x = x.to_i
      @y = y.to_i
      @z = z.to_i
    end
  end
end
