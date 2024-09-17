#!/bin/bash

docker network create manual_default

docker compose run --rm app bundle exec rails db:setup
