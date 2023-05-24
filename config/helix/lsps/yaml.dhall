let yaml =
      { command = "yaml-language-server"
      , args = [ "--stdio" ]
      , config =
        { yaml =
          { customTags =
            [ "!And"
            , "!And sequence"
            , "!If"
            , "!If sequence"
            , "!Not"
            , "!Not sequence"
            , "!Equals"
            , "!Equals sequence"
            , "!Or"
            , "!Or sequence"
            , "!FindInMap"
            , "!FindInMap sequence"
            , "!Base64"
            , "!Join"
            , "!Join sequence"
            , "!Cidr"
            , "!Ref"
            , "!Sub"
            , "!Sub sequence"
            , "!GetAtt"
            , "!GetAZs"
            , "!ImportValue"
            , "!ImportValue sequence"
            , "!Select"
            , "!Select sequence"
            , "!Split"
            , "!Split sequence"
            ]
          , keyOrdering = False
          , format =
            { enable = True, singleQuote = False, bracketingSpacing = True }
          , validate = True
          , completion = True
          }
        , provideFormatter = True
        }
      }

in  { yaml }
