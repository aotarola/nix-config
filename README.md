# Nix config

Home configuration for all my Linux and MacOS hosts using nix pkgs.

This configuration builds [home-manager][hm] per architecture with a config that uses my
hostnames as config entries:

1. `aotarola@ivory`: points to my Mac Mini M1
1. `aotarola@ebony`: points to my Macbook Air Intel

Feel free to fork and customize it.

[hm]: https://github.com/nix-community/home-manager

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
1. Clone the repo

    ```sh
    git clone git@github.com:aotarola/nix-config.git ~/.config/nixpkgs
    ```
1. Build it using flakes

    ```sh
    nix build --no-link ~/.config/nixpkgs#homeConfigurations.$USER@$(hostname -s).activationPackage
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

_NOTE_: The alias _hms_ stands for `home-manager switch` (although it has more options bundled in, you can see them with `alias hms`)

_CAVEAT_: If you are configuring a new host from scratch, you might not have 
access to git, if that is so, feel free to download a binary for it.
