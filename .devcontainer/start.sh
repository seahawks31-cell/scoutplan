#!/usr/bin/env bash
# Starts Scoutplan on port 3000 plus the background worker that sends email.
cd /workspaces/scoutplan
bin/jobs &
JOBS_PID=$!
trap 'kill $JOBS_PID 2>/dev/null' EXIT
echo
echo "Open the PORTS tab and click the globe next to 'Scoutplan (3000)'."
echo "Sign in with  admin@example.com  /  scoutplan123"
echo "Press Ctrl+C here to stop."
echo
bin/rails server -b 0.0.0.0 -p 3000
