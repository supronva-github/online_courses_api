#!/bin/bash

echo "Running database setup..."

echo "Setting up the development database..."
RAILS_ENV=development bin/rails db:prepare && echo "Development database prepared" || { echo "Failed to prepare development database"; exit 1; }

echo "Setting up the test database..."
RAILS_ENV=test bin/rails db:prepare && echo "Test database prepared" || { echo "Failed to prepare test database"; exit 1; }

exec "$@"
