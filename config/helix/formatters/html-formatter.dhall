let html-formatter =
      { command = "efm-langserver"
      , config =
        { languages.html
          =
          [ { formatCommand = "prettier --parser html", formatStdin = True } ]
        , documentFormatting = True
        }
      }

in  { html-formatter }
