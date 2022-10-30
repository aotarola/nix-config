# Nix config

Configuration for all my Linux and MacOS hosts using nix pkgs.

## Installation

1. Install [Nix](https://nixos.org/download.html)

1. Enable experimental features

    ```sh
    echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
    ```
1. clone the repo

    ```sh
    git clone git@github.com:aotarola/nix-config.git ~/.config/nixpkgs
    ```
1. Build it using flakes

    ```sh
    nix build --no-link #homeConfigurations.$USER@$(hostname -s).activationPackage
    ```

1. Activate it

    ```sh
    "$(nix path-info ~/.config/nixpkgs#homeConfigurations.$USER@$(hostname -s).activationPackage)"/activate
    ```

## Usage

Everytime a new config change is done, update the system with:

```sh
hms	
```

NOTE: The alias _hms_ stands for `home-manager switch` (although it has more options bundled in, you can see it with `alias hms`)
