#!/usr/bin/env bash
# exit on error
set -o errexit

# Явно исключаем гемы из групп development и test
bundle config set --local without 'development:test'

bundle install
yarn install
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:migrate
