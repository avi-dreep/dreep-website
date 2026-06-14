#!/bin/bash
# Commit all changes and push to GitHub → triggers GitHub Pages deploy
git add -A
git commit -m "${1:-update site}" 2>/dev/null || echo "Nothing new to commit."
git push
echo "✓ Deployed — live in ~60s at https://avi-dreep.github.io/dreep-website/"
