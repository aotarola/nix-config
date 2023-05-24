let markdown-linter =
      { command = "efm-langserver"
      , config.languages.markdown
        =
        [ { lintCommand = "markdownlint --stdin"
          , lintIgnoreExitCode = True
          , lintStdin = True
          }
        ]
      }

in  { markdown-linter }
