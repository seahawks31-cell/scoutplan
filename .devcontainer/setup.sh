#!/usr/bin/env bash
# Runs once when the codespace is created: installs gems, builds the databases and CSS,
# and loads a demo troop you can sign in to.
set -euo pipefail
cd /workspaces/scoutplan
until pg_isready -q; do echo "Waiting for the database..."; sleep 2; done
bundle install
bin/rails db:prepare
RAILS_ENV=test bin/rails db:prepare
bin/rails tailwindcss:build
bin/rails runner .devcontainer/demo_data.rb
echo
echo "Setup finished. Next, type:  bash .devcontainer/test.sh   (runs the tests)"
echo "                      then:  bash .devcontainer/start.sh  (starts Scoutplan)"
