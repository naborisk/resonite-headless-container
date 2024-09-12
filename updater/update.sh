#!/bin/sh
CHECK_TIME_UPDATED=$(curl https://api.steamcmd.net/v1/info/2519830 | jq -r '.data."2519830".depots.branches.headless.timeupdated')

echo $CHECK_TIME_UPDATED
echo $LAST_UPDATED
# gh workflow run build.yaml --ref main
