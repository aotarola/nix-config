{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    helix-custom.url = "github:helix-editor/helix?rev=a79979462395a1804e59b97732481b15874187a7";
    rust-overlay.url = "github:oxalica/rust-overlay";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    utils.url = "github:numtide/flake-utils";
    nci.url = "github:yusdacra/nix-cargo-integration";
  };

  outputs =
    { self, nci, utils, home-manager, nixpkgs, helix-custom, rust-overlay }:
    utils.lib.eachDefaultSystem (system:
    let
      helixOverlay = import overlays/helix.nix helix-custom system;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = (_: true);
        overlays = [ helixOverlay (import rust-overlay) ];
      };
      homeConfig = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { username = "aotarola"; };
        modules = [ ./home.nix ];
      };
    in
    {
      homeConfigurations.andres = homeConfig;

      packages = {
        default = homeConfig.activationPackage;
      };
    });
}
