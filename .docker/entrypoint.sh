#!/bin/bash

echo "Running database setup..."

echo "Setting up the development database..."
RAILS_ENV=development bin/rails db:create && echo "Development database created" || { echo "Failed to create development database"; exit 1; }
RAILS_ENV=development bin/rails db:migrate && echo "Development migrations applied" || { echo "Failed to apply development migrations"; exit 1; }
RAILS_ENV=development bin/rails db:seed && echo "Development database seeded" || { echo "Failed to seed development database"; exit 1; }

echo "Setting up the test database..."
RAILS_ENV=test bundle exec rails db:migrate && echo "Test migrations applied" || { echo "Failed to apply test migrations"; exit 1; }

exec "$@"
