let
  settings = builtins.fromTOML (builtins.readFile ./../config/helix/config.toml);
  languages = import ../config/helix/languages.nix;
  in

{
  enable = true;
  inherit settings;
  inherit languages;
}
