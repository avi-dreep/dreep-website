#!/bin/bash
# Watch for file changes and auto-deploy to GitHub Pages
# Usage: ./watch.sh
# Requires: fswatch (Mac: brew install fswatch | Linux: apt install inotify-tools)

echo "👀 Watching for changes... (Ctrl+C to stop)"

if command -v fswatch &>/dev/null; then
  # macOS
  fswatch -o index.html project/assets/ | while read; do
    echo "🔄 Change detected — deploying..."
    git add -A
    git commit -m "auto: update $(date '+%H:%M:%S')"
    git push
    echo "✓ Live at https://avi-dreep.github.io/dreep-website/"
  done
elif command -v inotifywait &>/dev/null; then
  # Linux
  while inotifywait -e modify,create,delete -r index.html project/assets/ 2>/dev/null; do
    echo "🔄 Change detected — deploying..."
    git add -A
    git commit -m "auto: update $(date '+%H:%M:%S')"
    git push
    echo "✓ Live at https://avi-dreep.github.io/dreep-website/"
  done
else
  echo "Install fswatch first: brew install fswatch"
  exit 1
fi
