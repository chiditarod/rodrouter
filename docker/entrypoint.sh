#!/bin/sh

# env

bundle check || bundle install -j 20

exec "$@"
