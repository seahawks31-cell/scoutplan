#!/usr/bin/env bash
# Runs the tests for the newsletter-note change. Pass "all" to run the whole suite.
cd /workspaces/scoutplan
source .devcontainer/env.sh
if [ "${1:-}" = "all" ]; then
  bundle exec rspec
else
  bundle exec rspec spec/mailers/weekly_digest_spec.rb spec/jobs/send_weekly_digest_job_spec.rb spec/requests/digest_note_spec.rb
fi
