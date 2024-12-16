# use the local version of the code instead of a globally installed gem
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "frontier"
require "json"
RSpec.configure do |config|
end

include Frontier
