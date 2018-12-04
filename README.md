# rodrouter

Ruby on Rails app to find viable routes for the CHIditarod

[![Build Status](https://travis-ci.com/chiditarod/rodrouter.svg?branch=master)](https://travis-ci.com/chiditarod/rodrouter) [![Maintainability](https://api.codeclimate.com/v1/badges/35fd2373a2aa927c424e/maintainability)](https://codeclimate.com/github/chiditarod/rodrouter/maintainability)


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

# Ideas

- Generate legs automatically using Google Maps API to calculate
distances between locations


