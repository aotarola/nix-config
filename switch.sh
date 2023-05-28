#!/usr/bin/env bash

cd config/helix
sh generate.sh
cd -

nix run . switch -- --flake .