let eslint_d =
      { formatCommand =
          "eslint_d --stdin --fix-to-stdout --stdin-filename=\${INPUT}"
      , formatStdin = True
      }

let eslint-formatter =
      { command = "efm-langserver"
      , config =
        { languages =
          { typescript = [ eslint_d ]
          , typescriptreact = [ eslint_d ]
          , javascript = [ eslint_d ]
          , javascriptreact = [ eslint_d ]
          }
        , documentFormatting = True
        }
      }

in  { eslint-formatter }
