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
      , shebangs : List Text
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

let indent2
    : Indent
    = { tab-width = 2, unit = "  " }

let indent4
    : Indent
    = { tab-width = 4, unit = "    " }

let withFormat =
      λ(lsp : LSP) → lsp ⫽ { only-features = lsp.only-features # [ "format" ] }

let withDiagnostics =
      λ(lsp : LSP) →
        lsp ⫽ { only-features = lsp.only-features # [ "diagnostics" ] }

let excludeFormat =
      λ(lsp : LSP) →
        lsp ⫽ { except-features = lsp.except-features # [ "format" ] }

let excludeDiagnostics =
      λ(lsp : LSP) →
        lsp ⫽ { except-features = lsp.except-features # [ "diagnostics" ] }

let emptyTextList = [] : List Text

let jsTSLspPack =
      [ excludeFormat (lsp "typescript")
      , withFormat (lsp "eslint-formatter")
      , lsp "vscode-eslint"
      , lsp "copilot"
      ]

let languages
    : List Language
    = [ { name = "dhall"
        , scope = "source.dhall"
        , injection-regex = "dhall"
        , file-types = [ "dhall" ]
        , auto-format = True
        , roots = emptyTextList
        , shebangs = emptyTextList
        , comment-token = "--"
        , indent = indent2
        , language-servers = [ lsp "dhall", lsp "copilot" ]
        }
      , { name = "toml"
        , scope = "source.toml"
        , injection-regex = "toml"
        , file-types = [ "toml", "poetry.lock" ]
        , auto-format = True
        , roots = emptyTextList
        , shebangs = emptyTextList
        , comment-token = "#"
        , indent = indent2
        , language-servers =
          [ lsp "copilot"
          , excludeFormat (lsp "toml")
          , withFormat (lsp "toml-formatter")
          ]
        }
      , { name = "yaml"
        , scope = "source.yaml"
        , injection-regex = "yml|yaml"
        , file-types = [ "yml", "yaml" ]
        , auto-format = True
        , roots = emptyTextList
        , shebangs = emptyTextList
        , comment-token = "#"
        , indent = indent2
        , language-servers =
          [ excludeFormat (lsp "yaml"), withFormat (lsp "yaml-formatter") ]
        }
      , { name = "prisma"
        , scope = "source.prisma"
        , injection-regex = "prisma"
        , file-types = [ "prisma" ]
        , auto-format = True
        , roots = [ "package.json" ]
        , shebangs = emptyTextList
        , comment-token = "//"
        , indent = indent2
        , language-servers = [ lsp "prisma" ]
        }
      , { name = "graphql"
        , scope = "source.graphql"
        , injection-regex = "graphql"
        , file-types = [ "gql", "graphql", "graphqls" ]
        , auto-format = True
        , roots = emptyTextList
        , shebangs = emptyTextList
        , comment-token = "#"
        , indent = indent2
        , language-servers = [ lsp "graphql" ]
        }
      , { name = "elm"
        , scope = "source.elm"
        , injection-regex = "elm"
        , file-types = [ "elm" ]
        , auto-format = True
        , roots = [ "elm.json" ]
        , shebangs = emptyTextList
        , comment-token = "--"
        , indent = indent4
        , language-servers = [ lsp "elm", withFormat (lsp "dhall-formatter") ]
        }
      , { name = "nix"
        , scope = "source.nix"
        , injection-regex = "nix"
        , file-types = [ "nix" ]
        , auto-format = True
        , roots = emptyTextList
        , shebangs = emptyTextList
        , comment-token = "#"
        , indent = indent2
        , language-servers = [ lsp "nix" ]
        }
      , { name = "html"
        , scope = "text.html.basic"
        , injection-regex = "html"
        , file-types = [ "html" ]
        , auto-format = True
        , roots = emptyTextList
        , shebangs = emptyTextList
        , comment-token = ""
        , indent = indent2
        , language-servers = [ lsp "html" ]
        }
      , { name = "json"
        , scope = "source.json"
        , injection-regex = "json"
        , file-types = [ "json", "jsonc", "arb", "ipynb", "geojson" ]
        , auto-format = True
        , roots = emptyTextList
        , shebangs = emptyTextList
        , comment-token = ""
        , indent = indent2
        , language-servers =
          [ excludeFormat (lsp "json"), withFormat (lsp "json-formatter") ]
        }
      , { name = "python"
        , scope = "source.json"
        , injection-regex = "python"
        , file-types =
          [ "py"
          , "pyi"
          , "py3"
          , "pyw"
          , "ptl"
          , ".pythonstartup"
          , ".pythonrc"
          , "SConstruct"
          ]
        , auto-format = True
        , roots = emptyTextList
        , shebangs = [ "python" ]
        , comment-token = "#"
        , indent = indent4
        , language-servers =
          [ excludeFormat (lsp "python")
          , withFormat (lsp "python-formatter")
          , lsp "copilot"
          ]
        }
      , { name = "markdown"
        , scope = "source.md"
        , injection-regex = "md|markdown"
        , file-types = [ "md", "markdown", "PULLREQ_EDITMSG" ]
        , auto-format = True
        , roots = [ ".marksman.toml" ]
        , shebangs = emptyTextList
        , comment-token = ""
        , indent = indent2
        , language-servers =
          [ excludeFormat (lsp "markdown")
          , withFormat (lsp "markdown-formatter")
          , withDiagnostics (lsp "markdown-linter")
          ]
        }
      , { name = "javascript"
        , scope = "source.js"
        , injection-regex = "js|javascript"
        , file-types = [ "js", "mjs", "cjs" ]
        , auto-format = True
        , roots = emptyTextList
        , shebangs = [ "node" ]
        , comment-token = "//"
        , indent = indent2
        , language-servers = jsTSLspPack
        }
      , { name = "typescript"
        , scope = "source.ts"
        , injection-regex = "ts|typescript"
        , file-types = [ "ts", "mts", "cts" ]
        , auto-format = True
        , roots = emptyTextList
        , shebangs = emptyTextList
        , comment-token = "//"
        , indent = indent2
        , language-servers = jsTSLspPack
        }
      , { name = "dockerfile"
        , scope = "source.dockerfile"
        , injection-regex = "docker|dockerfile"
        , file-types = [ "Dockerfile", "Containerfile" ]
        , auto-format = True
        , roots =
          [ "Dockerfile", "dockerfile", "Containerfile", "containerfile" ]
        , shebangs = emptyTextList
        , comment-token = "#"
        , indent = indent2
        , language-servers =
          [ excludeDiagnostics (lsp "docker")
          , withDiagnostics (lsp "hadolint-linter")
          ]
        }
      ]

in  {
      language-server = ./formatters/eslint-formatter.dhall
    , language-server = ./formatters/html-formatter.dhall
    , language-server = ./formatters/json-formatter.dhall
    , language-server = ./formatters/markdown-formatter.dhall
    , language-server = ./formatters/python-formatter.dhall
    , language-server = ./formatters/toml-formatter.dhall
    , language-server = ./formatters/yaml-formatter.dhall
    , language-server = ./linters/dockerfile-linter.dhall
    , language-server = ./linters/eslint-linter.dhall
    , language-server = ./linters/json-linter.dhall
    , language-server = ./linters/markdown-linter.dhall
    , language-server = ./lsps/c.dhall
    , language-server = ./lsps/copilot.dhall
    , language-server = ./lsps/dhall.dhall
    , language-server = ./lsps/dockerfile.dhall
    , language-server = ./lsps/elm.dhall
    , language-server = ./lsps/eslint.dhall
    , language-server = ./lsps/graphql.dhall
    , language-server = ./lsps/html.dhall
    , language-server = ./lsps/json.dhall
    , language-server = ./lsps/markdown.dhall
    , language-server = ./lsps/nix.dhall
    , language-server = ./lsps/prisma.dhall
    , language-server = ./lsps/python.dhall
    , language-server = ./lsps/toml.dhall
    , language-server = ./lsps/typescript-deno.dhall
    , language-server = ./lsps/yaml.dhall
    , languages
    }
