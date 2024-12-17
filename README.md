# Frontier.rb
Library to handle EVE Frontier graph and pathfinding operations.

_Work in progress._

Limitations:
- no graph database implemented (TODO), i.e., you have to rebuild the graph each time you run computations which takes some time
- path finding on 24k star systems can hit the limits of Ruby (SystemStackError: stack level too deep), try running shorter queries over less distance and combine the results

## Installation
The gem is not published yet, but yuo can install it locally:

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

### Shortest path between two star systems
Get the shortest path between `D:S299` and `Y:1SII`.

```ruby
best_smart_gate_path = UNIVERSE_GRAPH.shortest_path("D:S299", "Y:1SII")
```

See [examples/](./examples/) for usage and options to fine-tune.

```ruby
❯ ruby examples/distance.rb "D:S299" "Y:1SII"
1974.926982542737
```

```ruby
❯ ruby examples/pathfinder.rb
Mapping all star systems ...    done.
Building universe graph ...    done.
{"source"=>"D:S299",
 "dest"=>"Y:1SII",
 "path"=>["D:S299", "G.QXJ.4SH", "P:S696", "Q:1A97", "J:3K85", "Y:1SII"],
 "dist"=>1978.63507044974}
```

## Testing
To run tests, simply use `rspec`.

## License and Credits
The `frontier` gem is licensed under the conditions of [Apache 2.0](./LICENSE.txt). Please see [AUTHORS](./AUTHORS.txt) for contributors and copyright notices.
