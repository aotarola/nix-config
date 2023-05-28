let
  settings = builtins.fromTOML (builtins.readFile ./../config/helix/config.toml);
  languages = builtins.fromTOML (builtins.readFile ./../config/helix/languages.toml);
in
{
  enable = true;
  inherit settings;
  inherit languages;
}
