#!/bin/sh
CHECK_TIME_UPDATED=$(curl https://api.steamcmd.net/v1/info/2519830 | jq -r '.data."2519830".depots.branches.headless.timeupdated')

echo CHECK_TIME_UPDATED: $CHECK_TIME_UPDATED
echo LAST_UPDATED: $LAST_UPDATED

if [ "$CHECK_TIME_UPDATED" != "$LAST_UPDATED" ] && [ "$CHECK_TIME_UPDATED" != null ]; then
  echo "New update found, updating..., last updated: $LAST_UPDATED -> $CHECK_TIME_UPDATED"

  curl -L \
    -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $GH_TOKEN" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/repos/naborisk/resonite-headless-container/actions/workflows/build.yaml/dispatches \
    -d '{"ref":"main"}'

  curl -L \
    -X PATCH \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $PAT" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/repos/naborisk/resonite-headless-container/actions/variables/LAST_UPDATED \
    -d '{"name":"LAST_UPDATED","value":"'"$CHECK_TIME_UPDATED"'"}'

  # gh workflow run build.yaml --ref main
  # gh variable set LAST_UPDATED $CHECK_TIME_UPDATED
else
  echo "No need to update, last updated: $LAST_UPDATED -> $CHECK_TIME_UPDATED"
fi
