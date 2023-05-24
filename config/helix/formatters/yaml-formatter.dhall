let yaml-formatter =
      { command = "efm-langserver"
      , config =
        { languages.yaml
          =
          [ { formatCommand = "prettier --parser yaml", formatStdin = True } ]
        , documentFormatting = True
        }
      }

in  { yaml-formatter }
