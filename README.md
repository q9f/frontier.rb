# Frontier.rb
Library to handle EVE Frontier graph and pathfinding operations.

_Work in progress._


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
Get the shortest path between `E.2HM.2RR` and `I.EXP.NJ7`.

```ruby
best_smart_gate_path = UNIVERSE_GRAPH.shortest_path("E.2HM.2RR", "I.EXP.NJ7")
```

See [examples/distance.rb](./examples/distance.rb) for an example and options to fine-tune.

## Testing
To run tests, simply use `rspec`.

## License and Credits
The `frontier` gem is licensed under the conditions of [Apache 2.0](./LICENSE.txt). Please see [AUTHORS](./AUTHORS.txt) for contributors and copyright notices.
