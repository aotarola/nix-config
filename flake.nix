{
  description = "My Home Manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { home-manager, nixpkgs, ... }:
    let
      username = "aotarola";
    in
    let
      configFor = system: {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./home.nix
          {
            home = {
              username = "aotarola";
              homeDirectory = /Users/aotarola;
              stateVersion = "22.05";
            };
          }
        ];
      };
    in
    {
      homeConfigurations."${username}@ivory" = home-manager.lib.homeManagerConfiguration (configFor "aarch64-darwin");
      homeConfigurations."${username}@ebony" = home-manager.lib.homeManagerConfiguration (configFor "x86_64-darwin");
    };
}
