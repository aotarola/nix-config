let json-formatter =
      { command = "efm-langserver"
      , config =
        { languages.json = [ { formatCommand = "fixjson" } ]
        , documentFormatting = True
        }
      }

in  { json-formatter }
