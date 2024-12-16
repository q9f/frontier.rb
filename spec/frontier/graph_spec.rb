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

    it "is dijkstra algorithm works with frontier systems #shortest_path" do
      graph = Graph.new
      graph.add_edge("D:S299", "P:S696", 723.3487563)
      graph.add_edge("D:S299", "A 2560", 14.345793)
      graph.add_edge("D:S299", "E.2HM.2RR", 9.39459783)
      graph.add_edge("P:S696", "I.EXP.NJ7", 1534.2048745)
      graph.add_edge("P:S696", "E.2HM.2RR", 210)
      graph.add_edge("I.EXP.NJ7", "E.2HM.2RR", 411.3489576)
      graph.add_edge("I.EXP.NJ7", "G.QXJ.4SH", 6.349587)
      graph.add_edge("E.2HM.2RR", "A 2560", 2)
      graph.add_edge("A 2560", "G.QXJ.4SH", 0.009)
      path = graph.shortest_path("D:S299", "G.QXJ.4SH")
      expect(path["dest"]).to eq "G.QXJ.4SH"
      expect(path["dist"]).to eq 11.40359783
      expect(path["path"]).to eq ["D:S299", "E.2HM.2RR", "A 2560", "G.QXJ.4SH"]
      expect(path["source"]).to eq "D:S299"
    end

    it "is dijkstra algorithm works without route #shortest_path" do
      graph = Graph.new
      graph.add_edge("D:S299", "P:S696", 723.3487563)
      graph.add_edge("D:S299", "A 2560", 14.345793)
      graph.add_edge("P:S696", "I.EXP.NJ7", 1534.2048745)
      graph.add_edge("P:S696", "E.2HM.2RR", 210)
      graph.add_edge("I.EXP.NJ7", "E.2HM.2RR", 411.3489576)
      graph.add_edge("I.EXP.NJ7", "G.QXJ.4SH", 6.349587)
      graph.add_edge("A 2560", "G.QXJ.4SH", 0.009)
      graph.add_edge("Innocence", "ORT-D19", 9.39459783)
      graph.add_edge("V-016", "Innocence", 2)
      path = graph.shortest_path("D:S299", "Innocence")
      expect(path["dest"]).to eq "Innocence"
      expect(path["dist"]).to eq -999
      expect(path["path"]).to eq ["no path"]
      expect(path["source"]).to eq "D:S299"
    end
  end
end
