# Nix config

Home configuration for all my programs, managed with [home-manager](https://github.com/nix-community/home-manager) and [Nix flakes](https://nixos.wiki/wiki/Flakes).

To fork this config, change the `username` variable in `flake.nix`.

## Installation

### macOS

1. Install [Nix](https://nixos.org/download.html)

   ```sh
   sh <(curl -L https://nixos.org/nix/install)
   ```

1. Enable experimental features

   ```sh
   mkdir -p ~/.config/nix
   echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
   ```

1. Install [Ghostty](https://ghostty.org/) via `.dmg` or Homebrew

   ```sh
   brew install --cask ghostty
   ```

1. Clone the repo and apply

   ```sh
   git clone git@github.com:aotarola/nix-config.git ~/.config/nixpkgs
   cd ~/.config/nixpkgs && ./switch.sh
   ```

### Arch Linux

1. Install Nix

   ```sh
   sudo pacman -S nix
   sudo systemctl enable --now nix-daemon.service
   sudo usermod -aG nix-users $USER
   ```

   Then log out and back in.

1. Enable experimental features

   ```sh
   mkdir -p ~/.config/nix
   echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
   ```

1. Clone the repo and apply

   ```sh
   git clone git@github.com:aotarola/nix-config.git ~/.config/nixpkgs
   cd ~/.config/nixpkgs && ./switch.sh
   ```

## Usage

After making config changes, apply them with:

```sh
cd ~/.config/nixpkgs && ./switch.sh
```
