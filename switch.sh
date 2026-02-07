#!/usr/bin/env bash
if [[ "$(uname -s)" == "Darwin" ]]; then
    home-manager switch --flake .#aotarola
else
    home-manager switch --flake .#aotarola@linux
fi