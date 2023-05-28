# Nix config

Home configuration for all my programs

It has my username hardcoded, but you can fork and change it to yours

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
1. Build it

    ```sh
    ./switch.sh
    ```

## Usage

Everytime a new config change is done, update the system with:

```sh
./switch.sh
```

_CAVEAT_: If you are configuring a new host from scratch, you might not have 
access to git, if that is so, feel free to download a binary for it.
