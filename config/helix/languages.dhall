let Indent = { tab-width : Natural, unit : Text }

let LSP =
      { name : Text, except-features : List Text, only-features : List Text }

let Language =
      { name : Text
      , scope : Text
      , injection-regex : Text
      , file-types : List Text
      , auto-format : Bool
      , roots : List Text
      , comment-token : Text
      , language-servers : List LSP
      , indent : Indent
      }

let lsp
    : ∀(name : Text) → LSP
    = λ(name : Text) →
        { name
        , except-features = [] : List Text
        , only-features = [] : List Text
        }

let standardIndent
    : Indent
    = { tab-width = 2, unit = "  " }

let languages
    : List Language
    = [ { name = "dhall"
        , scope = "source.dhall"
        , injection-regex = "dhall"
        , file-types = [ "dhall" ]
        , auto-format = True
        , roots = [] : List Text
        , comment-token = "--"
        , language-servers =
          [ { name = "something"
            , except-features = [ "other" ]
            , only-features = [ "boo" ]
            }
          , lsp "dhall-lsp-server"
          , lsp "copilot"
          ]
        , indent = standardIndent
        }
      , { name = "toml"
        , scope = "source.toml"
        , injection-regex = "toml"
        , file-types = [ "toml", "poetry.lock" ]
        , auto-format = True
        , roots = [] : List Text
        , comment-token = "#"
        , language-servers = [ lsp "toml" ]
        , indent = standardIndent
        }
      ]

in  { languages }
