# Nix config

Home configuration for all my programs

It has my username hard-coded, but you can fork and change it to yours

## Installation

1. Install [Nix](https://nixos.org/download.html)

1. Create the config folders

   ```sh
   mkdir -p ~/.config/nixpkgs
   ```

1. Enable experimental features

   ```sh
   echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
   ```

1. Set unstable channel

   ```sh
   nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable
   ```

1. Clone the repo

   ```sh
   git clone git@github.com:aotarola/nix-config.git ~/.config/nixpkgs
   ```

1. Build it

   ```sh
   ./switch.sh
   ```

## Usage

Every time a new config change is done, update the system with:

```sh
./switch.sh
```

_CAVEAT_: third maybenot change
