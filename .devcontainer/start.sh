#!/usr/bin/env bash
# Starts Scoutplan on port 3000 plus the background worker that sends email.
cd /workspaces/scoutplan
source .devcontainer/env.sh
bin/jobs &
JOBS_PID=$!
ruby .devcontainer/forward_port.rb 1080 mailcatcher 1080 &
INBOX_PID=$!
trap 'kill $JOBS_PID $INBOX_PID 2>/dev/null' EXIT
echo
echo "Open the PORTS tab and click the globe next to 'Scoutplan (3000)'."
echo "Sign in with  admin@example.com  /  scoutplan123"
echo "Test emails: PORTS tab, port 1080 (add it with 'Add Port' if it isn't listed)."
echo "Press Ctrl+C here to stop."
echo
bin/rails server -b 0.0.0.0 -p 3000
