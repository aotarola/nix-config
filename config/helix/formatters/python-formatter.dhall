let python-formatter =
      { command = "efm-langserver"
      , config =
        { languages.python
          =
          [ { formatCommand = "black --fast --quest -", formatStdin = True } ]
        , documentFormatting = True
        }
      }

in  { python-formatter }
