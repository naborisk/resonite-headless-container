#!/bin/sh
curl https://api.steamcmd.net/v1/info/2519830 | jq -r '.data."2519830".depots.branches.headless.timeupdated'
