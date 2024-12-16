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

require "set"

# Provides the {Frontier} module.
module Frontier

  # Implements a graph {Graph} in ruby that can be used to do pathfinding between nodes
  class Graph

    # The complete graph containing nodes with weighted edges
    # `{node => { edge1 => weight, edge2 => weight}, node2 => etc. ...`
    attr_reader :graph

    # The set of nodes of the graph
    attr_reader :nodes

    # The previous node in the ccurrent Dijkstra
    attr_reader :previous

    # The distance of the path
    attr_reader :distance

    # We assume this large number to be unreachable ("infinity")
    INFINITY = 1 << 128

    # Creates an empty graph
    def initialize
      # Contains the graph: `{node => { edge1 => weight, edge2 => weight}, node2 => etc. ...`
      @graph = {}
      @nodes = Set.new
    end

    # Connects each node with target and weight
    def connect_graph(source, target, weight)
      if (!graph.has_key?(source))
        graph[source] = { target => weight }
      else
        graph[source][target] = weight
      end
      nodes << source
    end

    # Connects each node bidirectional
    def add_edge(source, target, weight)

      # Directional graph
      connect_graph(source, target, weight)

      # Non-directed graph (inserts the other edge too)
      connect_graph(target, source, weight)
    end

    # Performs a pathfinding based of Wikipedia's pseudocode
    # http://en.wikipedia.org/wiki/Dijkstra's_algorithm
    def dijkstra(source)
      @distance = {}
      @previous = {}

      # Initialize an empty node
      nodes.each do |node|

        # Unknown distance from source to vertex
        @distance[node] = INFINITY

        # Previous node in optimal path from source
        @previous[node] = -1
      end

      # Distance from source to source
      @distance[source] = 0

      queue = Set.new
      queue << source
      while !queue.empty?
        u = queue.min_by { |n| @distance[n] }
        if (@distance[u] == INFINITY)
          break
        end
        queue.delete(u)
        graph[u].keys.each do |vertex|
          alt = @distance[u] + graph[u][vertex]
          if (alt < @distance[vertex])

            # A shorter path to v has been found
            @distance[vertex] = alt
            @previous[vertex] = u
            queue << vertex
          end
        end
      end
    end

    # To find the full shortest route to a node
    def find_path(dest)
      if @previous[dest] != -1
        find_path @previous[dest]
      end
      @path ||= []
      @path << dest
    end

    # Gets all shortests paths from source using Dijkstra
    def all_shortest_paths(source)
      all_paths = []
      dijkstra source
      nodes.each do |dest|
        @path = []
        find_path dest
        actual_distance = if @distance[dest] != INFINITY
            @distance[dest]
          else
            -999
          end
        all_paths << {
          "source" => source,
          "dest" => dest,
          "path" => @path,
          "dist" => actual_distance,
        }
      end
      all_paths
    end

    # Gets the shortest path beteen source and destination using Dijkstra
    def shortest_path(source, dest)
      dijkstra source
      @path = []
      find_path dest
      actual_distance = if @distance[dest] != INFINITY
          @distance[dest]
        else
          "no path"
        end
      path = {
               "source" => source,
               "dest" => dest,
               "path" => @path,
               "dist" => actual_distance,
             }
    end
  end
end
