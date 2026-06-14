#!/usr/bin/env bash
set -euo pipefail

REPO="kaowallet/kao"
FILE="$(dirname "$0")/index.html"

current=$(grep -oP '(?<=KAO_VERSION: )v\S+' "$FILE")
latest=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" | grep -oP '(?<="tag_name": ")[^"]+')

if [ "$current" = "$latest" ]; then
  echo "already on $current"
  exit 0
fi

sed -i "s/$current/$latest/g" "$FILE"
echo "$current -> $latest"
