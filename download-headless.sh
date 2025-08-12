#!/bin/bash

source .env

steamcmd +force_install_dir /Resonite \
  +login ${STEAM_USER} ${STEAM_PASS} \
  +app_license_request 2519830 \
  +app_update 2519830 -beta ${STEAM_BETA} -betapassword ${BETA_PASSWORD} validate \
  +quit
