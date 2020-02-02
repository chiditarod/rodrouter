# Cartographer

Ruby on Rails app that finds viable routes for the CHIditarod, based on
customizable criteria like leg length, overall race length, etc.

[![Build Status](https://travis-ci.com/chiditarod/cartographer.svg?branch=master)](https://travis-ci.com/chiditarod/cartographer) [![Maintainability](https://api.codeclimate.com/v1/badges/35fd2373a2aa927c424e/maintainability)](https://codeclimate.com/github/chiditarod/cartographer/maintainability)

## Runtime Environment

| Variable Name | Purpose |
| ---- | ------- |
| `GOOGLE_API_KEY` | Google Cloud Platform API key with access to the [Distance Matrix API](https://developers.google.com/maps/documentation/distance-matrix/intro) |

## Example Usage

```bash
bundle exec rake db:seed
GOOGLE_API_KEY=... bundle exec rails c
```

```ruby
# generate all legs using maps api
BulkLegCreator.perform_now(Location.all.map(&:id))
RouteGenerator.call(Race.first)

winners = Route.all.select(&:complete?)
puts winners.map(&:to_csv)
puts winners.map(&:to_s)
```

## Developer Setup

*Tested using OSX Mojave 10.14.2*.

Prerequisites

- [Xcode](https://itunes.apple.com/us/app/xcode/id497799835),
  [Docker](https://docs.pie.apple.com/artifactory/docker.html), [Homebrew](https://brew.sh/)

Install rbenv & Ruby

```bash
brew install rbenv
rbenv install $(cat .ruby-version)
gem install bundler
```

Install Gems

```bash
brew install libffi libpq

bundle config --local build.ffi --with-ldflags="-L/usr/local/opt/libffi/lib"
bundle config --local build.pg --with-opt-dir="/usr/local/opt/libpq"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/opt/libffi/lib/pkgconfig"

bundle install
```
