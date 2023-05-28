{
  "language-server" = {
    "c" = {
      "args" = [ "--log-file=/tmp/ccls.log" "-v=1" ];
      "command" = "ccls";
      };
    "copilot" = { "args" = [ "--stdio" ]; "command" = "copilot"; };
    "dhall" = { "command" = "dhall-lsp-server"; };
    "dockerfile" = {
      "args" = [ "--stdio" ];
      "command" = "docker-langserver";
      "config" = {
        "docker" = {
          "languageserver" = {
            "formatter" = { "ignoreMultilineInstructions" = false; };
            };
          };
        };
      };
    "dockerfile-linter" = {
      "command" = "efm-langserver";
      "config" = {
        "languages" = {
          "dockerfile" = [
            {
              "lintCommand" = "hadolint --no-color --ignore DL3018 --ignore DL3008";
              "lintFormats" = [ "%f:%l %m" ];
              "lintIgnoreExitCode" = true;
              "lintStdin" = true;
              }
            ];
          };
        };
      };
    "elm" = {
      "command" = "elm-language-server";
      "config" = { "elmLS" = { "elmReviewDiagnostics" = "error"; }; };
      };
    "eslint" = {
      "args" = [ "--stdio" ];
      "command" = "vscode-eslint-language-server";
      "config" = {
        "codeAction" = {
          "disableRuleComment" = {
            "enable" = true;
            "location" = "separateLine";
            };
          "experimental" = { "useFlatConfig" = false; };
          };
        "codeActionOnSave" = { "enable" = true; "mode" = "all"; };
        "format" = true;
        "nodePath" = "";
        "onIgnoredFiles" = "off";
        "packageManager" = false;
        "problems" = { "shorthenToSingleLine" = false; };
        "quiet" = false;
        "rulesCustomizations" = [];
        "run" = "onType";
        "useESLintClass" = false;
        "validate" = "on";
        "workingDirectory" = { "mode" = "location"; };
        };
      };
    "eslint-formatter" = {
      "command" = "efm-langserver";
      "config" = {
        "documentFormatting" = true;
        "languages" = {
          "javascript" = [
            {
              "formatCommand" = "eslint_d --stdin --fix-to-stdout --stdin-filename=\${INPUT}";
              "formatStdin" = true;
              }
            ];
          "javascriptreact" = [
            {
              "formatCommand" = "eslint_d --stdin --fix-to-stdout --stdin-filename=\${INPUT}";
              "formatStdin" = true;
              }
            ];
          "typescript" = [
            {
              "formatCommand" = "eslint_d --stdin --fix-to-stdout --stdin-filename=\${INPUT}";
              "formatStdin" = true;
              }
            ];
          "typescriptreact" = [
            {
              "formatCommand" = "eslint_d --stdin --fix-to-stdout --stdin-filename=\${INPUT}";
              "formatStdin" = true;
              }
            ];
          };
        };
      };
    "eslint-linter" = {
      "command" = "efm-langserver";
      "config" = {
        "languages" = {
          "javascript" = [
            {
              "lintCommand" = "eslint_d -f unix --stdin --stdin-filename=\${INPUT}";
              "lintIgnoreExitCode" = true;
              "lintStdin" = true;
              }
            ];
          "javascriptreact" = [
            {
              "lintCommand" = "eslint_d -f unix --stdin --stdin-filename=\${INPUT}";
              "lintIgnoreExitCode" = true;
              "lintStdin" = true;
              }
            ];
          "typescript" = [
            {
              "lintCommand" = "eslint_d -f unix --stdin --stdin-filename=\${INPUT}";
              "lintIgnoreExitCode" = true;
              "lintStdin" = true;
              }
            ];
          "typescriptreact" = [
            {
              "lintCommand" = "eslint_d -f unix --stdin --stdin-filename=\${INPUT}";
              "lintIgnoreExitCode" = true;
              "lintStdin" = true;
              }
            ];
          };
        };
      };
    "graphql" = {
      "args" = [ "server" "m" "stream" ];
      "command" = "graphql-lsp";
      };
    "html" = {
      "args" = [ "--stdio" ];
      "command" = "vscode-html-language-server";
      };
    "html-formatter" = {
      "command" = "efm-langserver";
      "config" = {
        "documentFormatting" = true;
        "languages" = {
          "html" = [
            {
              "formatCommand" = "prettier --parser html";
              "formatStdin" = true;
              }
            ];
          };
        };
      };
    "json" = {
      "args" = [ "--stdio" ];
      "command" = "vscode-json-language-server";
      };
    "json-formatter" = {
      "command" = "efm-langserver";
      "config" = {
        "documentFormatting" = true;
        "languages" = { "json" = [ { "formatCommand" = "fixjson"; } ]; };
        };
      };
    "json-linter" = {
      "command" = "efm-langserver";
      "config" = {
        "languages" = {
          "json" = [
            {
              "lint-formats" = [ "line %l, col%c, found: %m" ];
              "lintCommand" = "jsonlint -c";
              "lintIgnoreExitCode" = true;
              "lintStdin" = true;
              "prefix" = "jsonlint";
              }
            ];
          };
        };
      };
    "markdown" = { "command" = "marksman"; };
    "markdown-formatter" = {
      "command" = "efm-langserver";
      "config" = {
        "documentFormatting" = true;
        "languages" = {
          "markdown" = [
            {
              "formatCommand" = "prettier --parser markdown";
              "formatStdin" = true;
              }
            ];
          };
        };
      };
    "markdown-linter" = {
      "command" = "efm-langserver";
      "config" = {
        "languages" = {
          "markdown" = [
            {
              "lintCommand" = "markdownlint --stdin";
              "lintIgnoreExitCode" = true;
              "lintStdin" = true;
              }
            ];
          };
        };
      };
    "nix" = { "command" = "nil"; };
    "prisma" = {
      "args" = [ "--stdio" ];
      "command" = "prisma-language-server";
      };
    "python" = { "args" = [ "--stdio" ]; "command" = "pyright-langserver"; };
    "python-formatter" = {
      "command" = "efm-langserver";
      "config" = {
        "documentFormatting" = true;
        "languages" = {
          "python" = [
            {
              "formatCommand" = "black --fast --quest -";
              "formatStdin" = true;
              }
            ];
          };
        };
      };
    "toml" = { "args" = [ "lsp" "stdio" ]; "command" = "taplo"; };
    "toml-formatter" = {
      "command" = "efm-langserver";
      "config" = {
        "documentFormatting" = true;
        "languages" = {
          "toml" = [
            {
              "formatCommand" = "prettier --parser toml";
              "formatStdin" = true;
              }
            ];
          };
        };
      };
    "typescript-deno" = {
      "args" = [ "lsp" ];
      "command" = "deno";
      "config" = { "enable" = true; "lint" = true; "unstable" = true; };
      };
    "yaml" = {
      "args" = [ "--stdio" ];
      "command" = "yaml-language-server";
      "config" = {
        "provideFormatter" = true;
        "yaml" = {
          "completion" = true;
          "customTags" = [
            "!And"
            "!And sequence"
            "!If"
            "!If sequence"
            "!Not"
            "!Not sequence"
            "!Equals"
            "!Equals sequence"
            "!Or"
            "!Or sequence"
            "!FindInMap"
            "!FindInMap sequence"
            "!Base64"
            "!Join"
            "!Join sequence"
            "!Cidr"
            "!Ref"
            "!Sub"
            "!Sub sequence"
            "!GetAtt"
            "!GetAZs"
            "!ImportValue"
            "!ImportValue sequence"
            "!Select"
            "!Select sequence"
            "!Split"
            "!Split sequence"
            ];
          "format" = {
            "bracketingSpacing" = true;
            "enable" = true;
            "singleQuote" = false;
            };
          "keyOrdering" = false;
          "validate" = true;
          };
        };
      };
    "yaml-formatter" = {
      "command" = "efm-langserver";
      "config" = {
        "documentFormatting" = true;
        "languages" = {
          "yaml" = [
            {
              "formatCommand" = "prettier --parser yaml";
              "formatStdin" = true;
              }
            ];
          };
        };
      };
    };
  "languages" = [
    {
      "auto-format" = true;
      "comment-token" = "--";
      "file-types" = [ "dhall" ];
      "indent" = { "tab-width" = 2; "unit" = "  "; };
      "injection-regex" = "dhall";
      "language-servers" = [
        { "except-features" = []; "name" = "dhall"; "only-features" = []; }
        { "except-features" = []; "name" = "copilot"; "only-features" = []; }
        ];
      "name" = "dhall";
      "roots" = [];
      "scope" = "source.dhall";
      "shebangs" = [];
      }
    {
      "auto-format" = true;
      "comment-token" = "#";
      "file-types" = [ "toml" "poetry.lock" ];
      "indent" = { "tab-width" = 2; "unit" = "  "; };
      "injection-regex" = "toml";
      "language-servers" = [
        { "except-features" = []; "name" = "copilot"; "only-features" = []; }
        {
          "except-features" = [ "format" ];
          "name" = "toml";
          "only-features" = [];
          }
        {
          "except-features" = [];
          "name" = "toml-formatter";
          "only-features" = [ "format" ];
          }
        ];
      "name" = "toml";
      "roots" = [];
      "scope" = "source.toml";
      "shebangs" = [];
      }
    {
      "auto-format" = true;
      "comment-token" = "#";
      "file-types" = [ "yml" "yaml" ];
      "indent" = { "tab-width" = 2; "unit" = "  "; };
      "injection-regex" = "yml|yaml";
      "language-servers" = [
        {
          "except-features" = [ "format" ];
          "name" = "yaml";
          "only-features" = [];
          }
        {
          "except-features" = [];
          "name" = "yaml-formatter";
          "only-features" = [ "format" ];
          }
        ];
      "name" = "yaml";
      "roots" = [];
      "scope" = "source.yaml";
      "shebangs" = [];
      }
    {
      "auto-format" = true;
      "comment-token" = "//";
      "file-types" = [ "prisma" ];
      "indent" = { "tab-width" = 2; "unit" = "  "; };
      "injection-regex" = "prisma";
      "language-servers" = [
        { "except-features" = []; "name" = "prisma"; "only-features" = []; }
        ];
      "name" = "prisma";
      "roots" = [ "package.json" ];
      "scope" = "source.prisma";
      "shebangs" = [];
      }
    {
      "auto-format" = true;
      "comment-token" = "#";
      "file-types" = [ "gql" "graphql" "graphqls" ];
      "indent" = { "tab-width" = 2; "unit" = "  "; };
      "injection-regex" = "graphql";
      "language-servers" = [
        { "except-features" = []; "name" = "graphql"; "only-features" = []; }
        ];
      "name" = "graphql";
      "roots" = [];
      "scope" = "source.graphql";
      "shebangs" = [];
      }
    {
      "auto-format" = true;
      "comment-token" = "--";
      "file-types" = [ "elm" ];
      "indent" = { "tab-width" = 4; "unit" = "    "; };
      "injection-regex" = "elm";
      "language-servers" = [
        { "except-features" = []; "name" = "elm"; "only-features" = []; }
        {
          "except-features" = [];
          "name" = "dhall-formatter";
          "only-features" = [ "format" ];
          }
        ];
      "name" = "elm";
      "roots" = [ "elm.json" ];
      "scope" = "source.elm";
      "shebangs" = [];
      }
    {
      "auto-format" = true;
      "comment-token" = "#";
      "file-types" = [ "nix" ];
      "indent" = { "tab-width" = 2; "unit" = "  "; };
      "injection-regex" = "nix";
      "language-servers" = [
        { "except-features" = []; "name" = "nix"; "only-features" = []; }
        ];
      "name" = "nix";
      "roots" = [];
      "scope" = "source.nix";
      "shebangs" = [];
      }
    {
      "auto-format" = true;
      "comment-token" = "";
      "file-types" = [ "html" ];
      "indent" = { "tab-width" = 2; "unit" = "  "; };
      "injection-regex" = "html";
      "language-servers" = [
        { "except-features" = []; "name" = "html"; "only-features" = []; }
        ];
      "name" = "html";
      "roots" = [];
      "scope" = "text.html.basic";
      "shebangs" = [];
      }
    {
      "auto-format" = true;
      "comment-token" = "";
      "file-types" = [ "json" "jsonc" "arb" "ipynb" "geojson" ];
      "indent" = { "tab-width" = 2; "unit" = "  "; };
      "injection-regex" = "json";
      "language-servers" = [
        {
          "except-features" = [ "format" ];
          "name" = "json";
          "only-features" = [];
          }
        {
          "except-features" = [];
          "name" = "json-formatter";
          "only-features" = [ "format" ];
          }
        ];
      "name" = "json";
      "roots" = [];
      "scope" = "source.json";
      "shebangs" = [];
      }
    {
      "auto-format" = true;
      "comment-token" = "#";
      "file-types" = [
        "py"
        "pyi"
        "py3"
        "pyw"
        "ptl"
        ".pythonstartup"
        ".pythonrc"
        "SConstruct"
        ];
      "indent" = { "tab-width" = 4; "unit" = "    "; };
      "injection-regex" = "python";
      "language-servers" = [
        {
          "except-features" = [ "format" ];
          "name" = "python";
          "only-features" = [];
          }
        {
          "except-features" = [];
          "name" = "python-formatter";
          "only-features" = [ "format" ];
          }
        { "except-features" = []; "name" = "copilot"; "only-features" = []; }
        ];
      "name" = "python";
      "roots" = [];
      "scope" = "source.json";
      "shebangs" = [ "python" ];
      }
    {
      "auto-format" = true;
      "comment-token" = "";
      "file-types" = [ "md" "markdown" "PULLREQ_EDITMSG" ];
      "indent" = { "tab-width" = 2; "unit" = "  "; };
      "injection-regex" = "md|markdown";
      "language-servers" = [
        {
          "except-features" = [ "format" ];
          "name" = "markdown";
          "only-features" = [];
          }
        {
          "except-features" = [];
          "name" = "markdown-formatter";
          "only-features" = [ "format" ];
          }
        {
          "except-features" = [];
          "name" = "markdown-linter";
          "only-features" = [ "diagnostics" ];
          }
        ];
      "name" = "markdown";
      "roots" = [ ".marksman.toml" ];
      "scope" = "source.md";
      "shebangs" = [];
      }
    {
      "auto-format" = true;
      "comment-token" = "//";
      "file-types" = [ "js" "mjs" "cjs" ];
      "indent" = { "tab-width" = 2; "unit" = "  "; };
      "injection-regex" = "js|javascript";
      "language-servers" = [
        {
          "except-features" = [ "format" ];
          "name" = "typescript";
          "only-features" = [];
          }
        {
          "except-features" = [];
          "name" = "eslint-formatter";
          "only-features" = [ "format" ];
          }
        {
          "except-features" = [];
          "name" = "vscode-eslint";
          "only-features" = [];
          }
        { "except-features" = []; "name" = "copilot"; "only-features" = []; }
        ];
      "name" = "javascript";
      "roots" = [];
      "scope" = "source.js";
      "shebangs" = [ "node" ];
      }
    {
      "auto-format" = true;
      "comment-token" = "//";
      "file-types" = [ "ts" "mts" "cts" ];
      "indent" = { "tab-width" = 2; "unit" = "  "; };
      "injection-regex" = "ts|typescript";
      "language-servers" = [
        {
          "except-features" = [ "format" ];
          "name" = "typescript";
          "only-features" = [];
          }
        {
          "except-features" = [];
          "name" = "eslint-formatter";
          "only-features" = [ "format" ];
          }
        {
          "except-features" = [];
          "name" = "vscode-eslint";
          "only-features" = [];
          }
        { "except-features" = []; "name" = "copilot"; "only-features" = []; }
        ];
      "name" = "typescript";
      "roots" = [];
      "scope" = "source.ts";
      "shebangs" = [];
      }
    {
      "auto-format" = true;
      "comment-token" = "#";
      "file-types" = [ "Dockerfile" "Containerfile" ];
      "indent" = { "tab-width" = 2; "unit" = "  "; };
      "injection-regex" = "docker|dockerfile";
      "language-servers" = [
        {
          "except-features" = [ "diagnostics" ];
          "name" = "docker";
          "only-features" = [];
          }
        {
          "except-features" = [];
          "name" = "hadolint-linter";
          "only-features" = [ "diagnostics" ];
          }
        ];
      "name" = "dockerfile";
      "roots" = [ "Dockerfile" "dockerfile" "Containerfile" "containerfile" ];
      "scope" = "source.dockerfile";
      "shebangs" = [];
      }
    ];
  }
