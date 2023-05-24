let eslint_d =
      { lintCommand = "eslint_d -f unix --stdin --stdin-filename=\${INPUT}"
      , lintIgnoreExitCode = True
      , lintStdin = True
      }

let eslint-linter =
      { command = "efm-langserver"
      , config.languages
        =
        { typescript = [ eslint_d ]
        , typescriptreact = [ eslint_d ]
        , javascript = [ eslint_d ]
        , javascriptreact = [ eslint_d ]
        }
      }

in  { eslint-linter }
