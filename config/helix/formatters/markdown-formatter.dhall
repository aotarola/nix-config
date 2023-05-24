let markdown-formatter =
      { command = "efm-langserver"
      , config =
        { languages.markdown
          =
          [ { formatCommand = "prettier --parser markdown", formatStdin = True }
          ]
        , documentFormatting = True
        }
      }

in  { markdown-formatter }
