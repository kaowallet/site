#!/usr/bin/env bash
set -euo pipefail

REPO="kaowallet/kao"
FILE="$(dirname "$0")/index.html"

current=$(grep -oE 'KAO_VERSION: v[^ ,"<]+' "$FILE" | head -1 | sed 's/KAO_VERSION: //')
latest=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" | grep -oE '"tag_name": "[^"]+"' | sed 's/"tag_name": "//;s/"$//')

if [ "$current" = "$latest" ]; then
  echo "already on $current"
  exit 0
fi

tmp=$(mktemp)
sed "s/$current/$latest/g" "$FILE" > "$tmp" && mv "$tmp" "$FILE"
echo "$current -> $latest"
