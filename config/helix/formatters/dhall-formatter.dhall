let dhall-formatter =
      { command = "efm-langserver"
      , config =
        { languages.dhall
          =
          [ { formatCommand = "dhall format", formatStdin = True } ]
        , documentFormatting = True
        }
      }

in  { dhall-formatter }
