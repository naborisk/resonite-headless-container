#!/bin/bash

source .env

steamcmd +force_install_dir /Resonite +login ${STEAM_USER} ${STEAM_PASS} +app_update 2519830 -beta headless -betapassword ${BETA_PASSWORD} validate +quit
