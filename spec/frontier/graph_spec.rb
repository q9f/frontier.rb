# -*- encoding : ascii-8bit -*-

require "spec_helper"

describe Graph do
  context "gist/piki" do
    # https://gist.github.com/piki/dc6a3ee8eb90be0f5c61dd972988094f

    let(:new_graph) {
      Graph.new
    }

    context "graph creation" do
      it "should initialize empty graph" do
        graph = new_graph
        expect(graph.graph).to eq({})
      end

      it "should initialize empty nodes" do
        graph = new_graph
        expect(graph.nodes).to eq(Set.new)
      end

      it "is connect graph with source, target, weight #connect_graph" do
        graph = new_graph
        graph.connect_graph("a", "b", 5)
        expect(graph.graph).to eq({ "a" => { "b" => 5 } })
      end

      it "is connect node with source, target, weight #connect_graph" do
        graph = new_graph
        graph.connect_graph("a", "b", 5)
        expect(graph.nodes).to include("a")
      end

      it "is graph connect  bidirectional #add_edge" do
        graph = new_graph
        graph.add_edge("a", "b", 5)
        expect(graph.graph.keys).to eq(["a", "b"])
      end
    end

    context "dijkstra's algorithm" do
      it "is dijkstras algorithm works to track distance #dijkstra" do
        graph = new_graph
        graph.add_edge("a", "b", 5)
        graph.add_edge("b", "c", 3)
        graph.add_edge("c", "d", 1)
        graph.dijkstra("a")
        expect(graph.distance).to eq({ "a" => 0, "b" => 5, "c" => 8, "d" => 9 })
      end

      it "is dijkstras algorithm works to track connected node #dijkstra" do
        graph = new_graph
        graph.add_edge("a", "b", 5)
        graph.add_edge("b", "c", 3)
        graph.add_edge("c", "d", 1)
        graph.dijkstra("a")
        expect(graph.previous).to eq({ "a" => -1, "b" => "a", "c" => "b", "d" => "c" })
      end

      it "is dijkstra algorithm find shortest path #shortest_path" do
        graph = new_graph
        graph.add_edge("a", "b", 5)
        graph.add_edge("b", "c", 3)
        graph.add_edge("c", "d", 1)
        path = graph.shortest_path("a", "c")
        expect(path["dest"]).to eq "c"
        expect(path["dist"]).to eq 8
        expect(path["path"]).to eq ["a", "b", "c"]
        expect(path["source"]).to eq "a"
      end

      it "is dijkstra algorithm find shortest path #all_shortest_paths" do
        graph = new_graph
        graph.add_edge("a", "b", 5)
        graph.add_edge("b", "c", 3)
        graph.add_edge("c", "d", 1)
        all_paths = graph.all_shortest_paths("a")
        expect(all_paths[0]["dest"]).to eq "a"
        expect(all_paths[0]["dist"]).to eq 0
        expect(all_paths[0]["path"]).to eq ["a"]
        expect(all_paths[0]["source"]).to eq "a"
        expect(all_paths[1]["dest"]).to eq "b"
        expect(all_paths[1]["dist"]).to eq 5
        expect(all_paths[1]["path"]).to eq ["a", "b"]
        expect(all_paths[1]["source"]).to eq "a"
        expect(all_paths[2]["dest"]).to eq "c"
        expect(all_paths[2]["dist"]).to eq 8
        expect(all_paths[2]["path"]).to eq ["a", "b", "c"]
        expect(all_paths[2]["source"]).to eq "a"
      end
    end
  end
  context "wikipedia" do
    # https://en.wikipedia.org/wiki/Dijkstra's_algorithm

    it "is dijkstra algorithm find shortest path #shortest_path" do
      graph = Graph.new
      graph.add_edge("a", "c", 7)
      graph.add_edge("a", "e", 14)
      graph.add_edge("a", "f", 9)
      graph.add_edge("c", "d", 15)
      graph.add_edge("c", "f", 10)
      graph.add_edge("d", "f", 11)
      graph.add_edge("d", "b", 6)
      graph.add_edge("f", "e", 2)
      graph.add_edge("e", "b", 9)
      path = graph.shortest_path("a", "b")
      expect(path["dest"]).to eq "b"
      expect(path["dist"]).to eq 20
      expect(path["path"]).to eq ["a", "f", "e", "b"]
      expect(path["source"]).to eq "a"
    end
  end
end
