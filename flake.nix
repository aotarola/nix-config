{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    helix-custom.url = "github:helix-editor/helix?rev=d9fe4798fa8f1a16b7151167d3258f70759d24e2";
    rust-overlay.url = "github:oxalica/rust-overlay";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, utils, home-manager, nixpkgs, nixpkgs-unstable, helix-custom, rust-overlay }:
    utils.lib.eachDefaultSystem (system:
    let
      helixOverlay = import overlays/helix.nix helix-custom system;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ helixOverlay (import rust-overlay) ];
      };
      homeConfig = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
            username = "aotarola";
            unstablePkgs = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
          };
        };
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
