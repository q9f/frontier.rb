# Frontier.rb
Library to handle EVE Frontier graph and pathfinding operations.

_Work in progress._

Limitations:
- no graph database implemented (TODO), i.e., you have to rebuild the graph each time you run computations which takes some time
- path finding on 24k star systems can hit the limits of Ruby (SystemStackError: stack level too deep), try running shorter queries over less distance and combine the results

## Installation
The gem is not published yet, but you can install it locally:

```
git clone https://github.com/q9f/frontier.rb
cd frontier
./bin/setup
```

## Running
Use the local version of the code instead of a globally installed gem:


```
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "frontier"
include Frontier
```

### Direct distance between two star systems
Get the direct distance between `D:S299` and `Y:1SII`.

```ruby
direct_distance = ALL_STARS["D:S299"].distance_ly(ALL_STARS["Y:1SII"])
```

See [examples/](./examples/) for usage and options to fine-tune.

```bash
❯ ruby examples/distance.rb "D:S299" "Y:1SII"
1974.926982542737
```

### Shortest jump-path between two star systems
Get the shortest path between `D:S299` and `Y:1SII`.

```ruby
best_smart_gate_path = UNIVERSE_GRAPH.shortest_path("D:S299", "Y:1SII")
```

See [examples/](./examples/) for usage and options to fine-tune.

```bash
❯ ruby examples/pathfinder.rb
Mapping all star systems ...    done.
Building universe graph ...    done.
{"source"=>"D:S299",
 "dest"=>"Y:1SII",
 "path"=>["D:S299", "G.QXJ.4SH", "P:S696", "Q:1A97", "J:3K85", "Y:1SII"],
 "dist"=>1978.63507044974}
```

### Frontier console

Run the console to make ad-hoc computations on the command line:

```bash
❯ ./bin/console
[1] pry(main)> g = Graph.new
=> #<Frontier::Graph:0x0000791d610ca920 @graph={}, @nodes=#<Set: {}>>
```

## Testing
To run tests, simply use `rspec`.

## License and Credits
The `frontier` gem is licensed under the conditions of [Apache 2.0](./LICENSE.txt). Please see [AUTHORS](./AUTHORS.txt) for contributors and copyright notices.
