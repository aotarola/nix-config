#!/usr/bin/env bash
# --impure: home.nix reads this machine's flags from .env (git-ignored), see .env.example.
cd "$(dirname "$0")"
if [[ "$(uname -s)" == "Darwin" ]]; then
    home-manager switch --flake .#aotarola --impure "$@"
else
    home-manager switch --flake .#aotarola@linux --impure "$@"
fi
