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

let lspWithOpts =
      λ(name : Text) →
      λ(opts : { include : List Text, exclude : List Text }) →
        { name, except-features = opts.include, only-features = opts.exclude }

let lsp =
      λ(name : Text) →
        lspWithOpts name { include = [] : List Text, exclude = [] : List Text }

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
        , language-servers = [ lsp "dhall-lsp-server", lsp "copilot" ]
        , indent = standardIndent
        }
      , { name = "toml"
        , scope = "source.toml"
        , injection-regex = "toml"
        , file-types = [ "toml", "poetry.lock" ]
        , auto-format = True
        , roots = [] : List Text
        , comment-token = "#"
        , language-servers =
          [ lsp "copilot"
          , lspWithOpts
              "toml-lsp"
              { include = [] : List Text, exclude = [ "format" ] }
          , lspWithOpts
              "toml-formatter"
              { include = [ "format" ] : List Text, exclude = [] : List Text }
          ]
        , indent = standardIndent
        }
      ]

in  { languages }
