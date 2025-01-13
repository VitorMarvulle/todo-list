#!/usr/bin/env bash

# Fail on errors
set -e

# Echo commands to the terminal output
set -x

# Ensure the correct Ruby version is used
ruby_version=$(cat .ruby-version)
echo "Using Ruby version: $ruby_version"

chmod +x bin/*

# Install dependencies (ignores development and test groups)
bundle install --without development test

# Start the Rails server (sem banco de dados e migrações)
echo "Starting Rails server..."
bin/rails server -b 0.0.0.0 -p 3000

# Precompile assets (ignora a execução de testes)
echo "Precompiling assets..."
bin/rails assets:precompile

echo "Build process complete."
