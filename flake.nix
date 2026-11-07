{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # OpenTofu pinned on its own, to the version terminator requires (its infra/ says
    # required_version = "= 1.12.6"), so updating nixpkgs doesn't move it. Bump with terminator.
    nixpkgs-opentofu.url = "github:nixos/nixpkgs/34ca302a9572963c02e385c056be37c85ff51b77";
    helix-custom = {
      url = "github:helix-editor/helix?rev=b3d6e35f5d6d04152478403f654ce08b42ac310c";
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
    { self, utils, home-manager, nixpkgs, nixpkgs-unstable, nixpkgs-opentofu, helix-custom, rust-overlay }:
    let
      # Change this to your username when forking
      username = "aotarola";

      mkPkgs = system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (import overlays/helix.nix helix-custom system)
          (import overlays/asdf-vm.nix)
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
            inherit username;
            unstablePkgs = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
            opentofuPkgs = import nixpkgs-opentofu { inherit system; };
          };
          modules = [ ./home.nix ];
        };
    in
    {
      homeConfigurations.${username} = mkHomeConfig "aarch64-darwin";
      homeConfigurations."${username}@linux" = mkHomeConfig "x86_64-linux";
    };
}
