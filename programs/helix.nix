let
  settings = builtins.fromTOML (builtins.readFile ./../config/helix/config.toml);
in
{
  enable = true;
  inherit settings;
}
