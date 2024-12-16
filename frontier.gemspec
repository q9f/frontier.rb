# frozen_string_literal: true
# coding: utf-8

lib = File.expand_path("lib", __dir__).freeze
$LOAD_PATH.unshift lib unless $LOAD_PATH.include? lib

require "frontier/version"

Gem::Specification.new do |spec|
  spec.name = "frontier"
  spec.version = Frontier::VERSION
  spec.authors = ["Afri Schoedon"]
  spec.email = ["ruby@q9f.cc"]

  spec.summary = %q{Ruby EVE Frontier library.}
  spec.description = %q{Library to handle EVE Frontier graph and pathfinding operations.}
  spec.homepage = "https://github.com/q9f/frontier.rb"
  spec.license = "Apache-2.0"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/q9f/frontier.rb/issues",
    "changelog_uri" => "https://github.com/q9f/frontier.rb/blob/main/CHANGELOG.md",
    "documentation_uri" => "https://q9f.github.io/frontier.rb/",
    "github_repo" => "https://github.com/q9f/frontier.rb",
    "source_code_uri" => "https://github.com/q9f/frontier.rb",
  }.freeze

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib", "abis"]
  spec.test_files = spec.files.grep %r{^(test|spec|features)/}

  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = ">= 3.0", "< 4.0"

  # eth gem to enable smart contract framework
  spec.add_dependency "eth", "~> 0.5"
end
