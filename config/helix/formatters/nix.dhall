
let nix-formatter =
      { command = "efm-langserver"
      , config =
        { languages.html
          =
          [ { formatCommand = "nixpkgs-fmt", formatStdin = True } ]
        , documentFormatting = True
        }
      }

in  { nix-formatter }
