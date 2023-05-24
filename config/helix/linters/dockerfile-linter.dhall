let dockerfile-linter =
      { command = "efm-langserver"
      , config.languages.dockerfile
        =
        [ { lintCommand = "hadolint --no-color --ignore DL3018 --ignore DL3008"
          , lintIgnoreExitCode = True
          , lintStdin = True
          , lintFormats = [ "%f:%l %m" ]
          }
        ]
      }

in  { dockerfile-linter }
