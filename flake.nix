{
  description = "My Home Manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
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
              username = username;
              homeDirectory = /Users/${username};
              stateVersion = "22.11";
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
