{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    helix-custom = {
      url = "github:helix-editor/helix?rev=98765acf25a43e6bb606bea1527226be4b290ea4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay.url = "github:oxalica/rust-overlay";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, utils, home-manager, nixpkgs, nixpkgs-unstable, helix-custom, rust-overlay }:
    let
      mkPkgs = system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (import overlays/helix.nix helix-custom system)
          (import rust-overlay)
        ];
      };

      mkHomeConfig = system:
        let
          pkgs = mkPkgs system;
        in
        home-manager.lib.homeManagerConfiguration {
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
      homeConfigurations.aotarola = mkHomeConfig "aarch64-darwin";
      homeConfigurations."aotarola@linux" = mkHomeConfig "x86_64-linux";
    };
}
