let eslint =
      { command = "vscode-eslint-language-server"
      , args = [ "--stdio" ]
      , config =
        { validate = "on"
        , packageManager = False
        , useESLintClass = False
        , format = True
        , quiet = False
        , onIgnoredFiles = "off"
        , rulesCustomizations = [] : List Text
        , run = "onType"
        , nodePath = ""
        , problems.shorthenToSingleLine = False
        , codeAction =
          { experimental.useFlatConfig = False
          , disableRuleComment = { enable = True, location = "separateLine" }
          }
        , codeActionOnSave = { enable = True, mode = "all" }
        , workingDirectory.mode = "location"
        }
      }

in  { eslint }
