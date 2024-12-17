---
name: Spec

on:
  pull_request:
    branches:
      - main
  push:
    branches:
      - main

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      fail-fast: false
      matrix:
        os: [ubuntu-latest, macos-latest]
        ruby: ['3.2', '3.3']
    steps:
    - uses: actions/checkout@v4
    - uses: ruby/setup-ruby@v1
      with:
        ruby-version: ${{ matrix.ruby }}
        bundler-cache: false
    - name: Gem Dependencies
      run: |
        bundle install
    - name: Run Tests
      run: |
        bundle exec rspec
