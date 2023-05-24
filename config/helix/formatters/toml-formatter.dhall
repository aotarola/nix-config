let toml-formatter =
      { command = "efm-langserver"
      , config =
        { languages.toml
          =
          [ { formatCommand = "prettier --parser toml", formatStdin = True } ]
        , documentFormatting = True
        }
      }

in  { toml-formatter }
