{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    helix-custom.url = "github:helix-editor/helix?rev=a7651f5bf027ec98645d571ab05a685d97e1b772";
    rust-overlay.url = "github:oxalica/rust-overlay";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    utils.url = "github:numtide/flake-utils";
    nci.url = "github:yusdacra/nix-cargo-integration";
  };

  outputs =
    { self, utils, home-manager, nixpkgs, helix-custom, nci, rust-overlay }:
    utils.lib.eachDefaultSystem (system:
    let
      helixOverlay = import overlays/helix.nix helix-custom system;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = (_: true);
        overlays = [ helixOverlay (import rust-overlay) ];
      };
      config = name:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = { username = name; };
          modules = [ ./home.nix ];

        };

    in
    {
      packages = {
        default = home-manager.defaultPackage.${system};
        homeConfigurations.aotarola = config "aotarola";
      };
    });
}
