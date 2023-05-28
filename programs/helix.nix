let
  settings = builtins.fromTOML (builtins.readFile ./../config/helix/config.toml);
  languages = {
    language-server = {
      rnix-lsp = {
        command = "rnix-lsp";
      };
    };
  };

  languages.language = [
    {
      name = "nix";
      auto-format = true;
      language-servers = [ "rnix-lsp" ];
    }
  ];

in
{
  enable = true;
  inherit settings;
  inherit languages;
}
