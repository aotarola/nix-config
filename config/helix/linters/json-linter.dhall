let json-linter =
      { command = "efm-langserver"
      , config.languages.json
        =
        [ { lintCommand = "jsonlint -c"
          , lintIgnoreExitCode = True
          , lintStdin = True
          , prefix = "jsonlint"
          , lint-formats = [ "line %l, col%c, found: %m" ]
          }
        ]
      }

in  { json-linter }
