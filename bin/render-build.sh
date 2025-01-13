#!/usr/bin/env bash

# Fail on errors
set -e

# Echo commands to the terminal output
set -x

# Ensure the correct Ruby version is used
ruby_version=$(cat .ruby-version)
echo "Using Ruby version: $ruby_version"

chmod +x bin/*

# Install dependencies
bundle install --without development test

# Prepare the database
echo "Preparing database..."
bin/rails db:create db:migrate

# Precompile assets
echo "Precompiling assets..."
bin/rails assets:precompile


echo "Build process complete."
