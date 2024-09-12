#!/bin/sh
CHECK_TIME_UPDATED=$(curl https://api.steamcmd.net/v1/info/2519830 | jq -r '.data."2519830".depots.branches.headless.timeupdated')

echo CHECK_TIME_UPDATED: $CHECK_TIME_UPDATED
echo LAST_UPDATED: $LAST_UPDATED

if [ "$CHECK_TIME_UPDATED" != "$LAST_UPDATED" ]; then
  echo "New update found, updating..., last updated: $LAST_UPDATED -> $CHECK_TIME_UPDATED"
  gh workflow run build.yaml --ref main
  gh variable set LAST_UPDATED $CHECK_TIME_UPDATED
else
  echo "No need to update, last updated: $LAST_UPDATED -> $CHECK_TIME_UPDATED"
fi
