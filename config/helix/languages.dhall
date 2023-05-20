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

let indent
    : Indent
    = { tab-width = 2, unit = "  " }

let withFormat =
      λ(lsp : LSP) → lsp ⫽ { only-features = lsp.only-features # [ "format" ] }

let excludeFormat =
      λ(lsp : LSP) →
        lsp ⫽ { except-features = lsp.except-features # [ "format" ] }

let languages
    : List Language
    = [ { name = "dhall"
        , scope = "source.dhall"
        , injection-regex = "dhall"
        , file-types = [ "dhall" ]
        , auto-format = True
        , roots = [] : List Text
        , comment-token = "--"
        , indent
        , language-servers = [ lsp "dhall-lsp-server", lsp "copilot" ]
        }
      , { name = "toml"
        , scope = "source.toml"
        , injection-regex = "toml"
        , file-types = [ "toml", "poetry.lock" ]
        , auto-format = True
        , roots = [] : List Text
        , comment-token = "#"
        , indent
        , language-servers =
          [ lsp "copilot"
          , excludeFormat (lsp "toml-lsp")
          , withFormat (lsp "toml-formatter")
          ]
        }
      , { name = "yaml"
        , scope = "source.yaml"
        , injection-regex = "yml|yaml"
        , file-types = [ "yml", "yaml" ]
        , auto-format = True
        , roots = [] : List Text
        , comment-token = "#"
        , indent
        , language-servers =
          [ excludeFormat (lsp "yaml-lsp"), withFormat (lsp "yaml-formatter") ]
        }
      ]

in  { languages }
