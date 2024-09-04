let
  settings =
    {
      theme = "catppuccin_mocha";
      editor = {
        color-modes = true;
        cursorline = true;
        end-of-line-diagnostics = "hint";
        inline-diagnostics = {
          cursor-line = "hint";
          other-lines = "error";
        };
        line-number = "relative";
        mouse = false;
        rulers = [ 80 ];
        bufferline = "multiple";
        shell = [ "zsh" "-c" ];
        indent-guides = {
          render = true;
          character = "┊";
          skip-levels = 1;
        };
        lsp = {
          display-messages = true;
          snippets = true;
          auto-signature-help = false;
          display-signature-help-docs = false;
        };

        file-picker = {
          git-ignore = true;
          hidden = false;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        soft-wrap =
          {
            enable = true;
          };

        statusline = {
          center = [ "file-name" ];
          left = [ "mode" "spinner" "version-control" ];
          right = [ "diagnostics" "selections" "position" "file-encoding" "file-line-ending" "file-type"  "position-percentage" "total-line-numbers" ];
        };
      };

      keys = {
        normal = {
          C-p = [ "goto_prev_diag" ];
          C-n = [ "goto_next_diag" ];
          C-r = [ ":config-reload" ":reload" ];
          C-l = {
            c = "@|hxai.sh ";
          };
          esc = [ "collapse_selection" "keep_primary_selection" ];
          ret = ":w";
          X = "extend_line_above";
          H = ":buffer-previous";
          L = ":buffer-next";
          D = ":buffer-close-others";
          G = [ "extend_to_line_bounds" "trim_selections" "change_selection" ];
          space = {
            c = ":bc";
            o = [ ":sh gh repo view --web" ];
          };
        };

        insert = {
          down = "move_line_down";
          up = "move_line_up";
          left = "move_char_left";
          right = "move_char_right";
        };
      };
    };

  languages = {
    language-server = {
      # LSPs

      ltex = {
        command = "ltex-ls";
        config = {
          ltex ={
            dictionary = {
              en-US = ["XOPS" "TAL" "DataOps" "runbook" "dataops" "Pydantic" "xops"];
            };
          };
        };
      };

      nix-lsp = {
        command = "nixd";
      };

      copilot = {
        command = "copilot";
        args = [ "--stdio" ];
      };

      json = {
        command = "vscode-json-language-server";
        args = [ "--stdio" ];
      };

      yaml = {
        command = "yaml-language-server";
        args = [ "--stdio" ];
        config = {
          yaml = {
            customTags = [
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
            keyOrdering = false;
            format = {
              enable = true;
              singleQuote = true;
              bracketingSpacing = true;
            };
            provideFormatter = false;
          };
        };
      };

      rust-analyzer = {
        config.rust-analyzer = {
          cargo.loadOutDirsFromCheck = true;
          checkOnSave.command = "clippy";
          procMacro.enable = true;
          lens = { references = true; methodReferences = true; };
          completion.autoimport.enable = true;
          experimental.procAttrMacros = true;
        };
      };

      eslint =
        {
          command = "vscode-eslint-language-server";
          args = [ "--stdio" ];
          config = {
            validate = "on";
            packageManager = "npm";
            usESLintClass = false;
            format = true;
            quiet = false;
            onIgnoredFiles = "off";
            rulesCustomizations = [ ];
            run = "onType";
            nodePath = "";

            problems = {
              shortenToSingleLine = false;
            };

            experimental = {
              useFlatConfig = false;
            };

            codeAction = {
              disableRuleComment = {
                enable = true;
                locatoin = "separateLine";
              };
              showDocumentation = {
                enable = true;
              };
              codeActionOnSave = {
                enable = true;
                mode = "all";
              };
            };

            workingDirectory = {
              mode = "location";
            };
          };
        };

      roc =
        {
          command = "roc_language_server";
        };

      prisma = {
        command = "prisma-language-server";
        args = [ "--stdio" ];
      };

      graphql = {
        command = "graphql-lsp";
        args = [ "server" "-m" "stream" ];
      };

      typescript =
        {
          command = "typescript-language-server";
          args = [ "--stdio" ];
        };

      deno = {
        command = "deno";
        args = [ "lsp" ];
        config = {
          lint = true;
          enable = true;
          unstable = true;
        };
      };

      html = {
        command = "vscode-html-language-server";
        args = [ "--stdio" ];
      };

      markdown = {
        command = "marksman";
        args = [ "server" ];
      };

      dockerfile =
        {
          command = "docker-langserver";
          args = [ "--stdio" ];
        };

      python =
        {
          command = "pyright-langserver";
          args = [ "--stdio" ];
          config = { 
            reportMissingtypeStubs = false;
            disableOrganizeImports = true;
          };
        };

      ruff-lsp = {
        command = "ruff-lsp";
        documenFormatting = true;
        settings = {
          run = "onSave";
        };
      };

      elm-lsp =
        {
          command = "elm-language-server";
          config = {
            elmReviewDiagnostics = "error";
          };
        };

      # Formatters

      json-formatter = {
        command = "efm-langserver";
        config = {
          documentFormatting = true;
          languages = {
            json = [{
              formatCommand = "prettier --parser json";
              formatStdin = true;
            }];
          };
        };
      };

      yaml-formatter = {
        command = "efm-langserver";
        config = {
          documentFormatting = true;
          languages = {
            yaml = [{
              formatCommand = "prettier --parser yaml";
              formatStdin = true;
            }];
          };
        };
      };

      html-formatter = {
        command = "efm-langserver";
        config = {
          documentFormatting = true;
          languages = {
            html = [{
              formatCommand = "prettier --parser html";
              formatStdin = true;
            }];
          };
        };
      };

      markdown-formatter = {
        command = "efm-langserver";
        config = {
          documentFormatting = true;
          languages = {
            markdown = [{
              formatCommand = "prettier --parser markdown";
              formatStdin = true;
            }];
          };
        };
      };

      eslint-formatter = {
        command = "efm-langserver";
        config = {
          documentFormatting = true;
          languages = {
            typescript = [{
              formatCommand = "eslint_d --stdin --fix-to-stdout --stdin-filename=\${INPUT}";
              formatStdin = true;
            }];
            typescriptreact = [{
              formatCommand = "eslint_d --stdin --fix-to-stdout --stdin-filename=\${INPUT}";
              formatStdin = true;
            }];
            javascript = [{
              formatCommand = "eslint_d --stdin --fix-to-stdout --stdin-filename=\${INPUT}";
              formatStdin = true;
            }];
            javascriptreact = [{
              formatCommand = "eslint_d --stdin --fix-to-stdout --stdin-filename=\${INPUT}";
              formatStdin = true;
            }];
          };
        };
      };

      python-formatter =
        {
          command = "efm-langserver";
          config = {
            documentFormatting = true;
            languages = {
              python = [{
                formatCommand = "black --quiet - | isort -";
                formatStdin = true;
              }];
            };
          };
        };

      ruff-formatter =
        {
          command = "efm-langserver";
          config = {
            documentFormatting = true;
            languages = {
              python = [{
                formatCommand = "ruff --fix -";
                formatStdin = true;
              }];
            };
          };
        };

      # Linters

      markdown-linter = {
        command = "efm-langserver";
        config = {
          languages = {
            markdown = [{
              lintCommand = "markdownlint --stdin";
              lintIgnoreExitCode = true;
              lintStdin = true;
            }];
          };
        };
      };

      dockerfile-linter = {
        command = "efm-langserver";
        config = {
          languages = {
            markdown = [{
              lintCommand = "hadolint --no-color --ignore DL3018 --ignore DL3008";
              lintIgnoreExitCode = true;
              lintStdin = true;
              lintFormats = [ "%f:%l %m" ];
            }];
          };
        };
      };

    };
  };

  languages.grammar = [
    {
      name = "roc";
      source = {
        git = "https://github.com/faldor20/tree-sitter-roc.git";
        rev = "ef46edd0c03ea30a22f7e92bc68628fb7231dc8a";
      };
    }
  ];

  languages.language =
    let
      jsTSLspPack = [
        {
          name = "eslint-formatter";
          only-features = [ "format" ];
        }
        {
          name = "typescript";
          except-features = [ "format" ];
        }
        "eslint"
        # "copilot"
      ];
    in
    [
      {
        name = "roc";
        scope = "source.roc";
        injection-regex = "roc";
        file-types = [ "roc" ];
        shebangs = [ "roc" ];
        roots = [ ];
        comment-token = "#";
        language-servers = [ "roc" ];
        indent =
          { tab-width = 2; unit = " "; };
        formatter =
          {
            command = "roc";
            args = [ "format" "--stdin" "--stdout" ];
          };
        auto-format = true;
      }
      {
        name = "nix";
        auto-format = false;
        language-servers = [ {name = "nix-lsp"; except-features = ["format"]; } ];
      }
      { name = "rust"; auto-format = true; file-types = [ "lalrpop" "rs" ]; language-servers = [ "rust-analyzer" ]; }
      { name = "sql"; auto-format = true; formatter.command = "pg_format"; }
      {
        name = "json";
        auto-format = true;
        language-servers = [
          { name = "json"; except-features = [ "format" ]; }
          { name = "json-formatter"; only-features = [ "format" ]; }
        ];
      }
      {
        name = "yaml";
        auto-format = true;
        language-servers = [
          { name = "yaml"; except-features = [ "format" ]; }
          { name = "yaml-formatter"; only-features = [ "format" ]; }
        ];
      }
      {
        name = "typescript";
        auto-format = true;
        language-servers = jsTSLspPack;
      }

      {
        name = "tsx";
        auto-format = true;
        language-servers = jsTSLspPack;
      }

      {
        name = "javascript";
        auto-format = true;
        language-servers = jsTSLspPack;
      }
      {
        name = "prisma";
        auto-format = true;
        language-servers = [ "prisma" ];
      }
      {
        name = "graphql";
        auto-format = true;
        language-servers = [ "graphql" ];
      }
      {
        name = "html";
        auto-format = true;
        language-servers = [
          { name = "html"; except-features = [ "format" ]; }
          { name = "html-formatter"; only-features = [ "format" ]; }
        ];
      }
      {
        name = "markdown";
        auto-format = true;
        language-servers = [
          {
            name = "markdown";
            except-features = [ "format" ];
          }
          {
            name = "markdown-formatter";
            only-features = [ "format" ];
          }
          {
            name = "markdown-linter";
            only-features = [ "diagnostics" ];
          }
          "ltex"
        ];
      }
      {
        name = "dockerfile";
        auto-format = true;
        language-servers = [
          {
            name = "dockerfile";
            except-features = [ "diagnostics" ];
          }
          {
            name = "dockerfile-linter";
            only-features = [ "diagnostics" ];
          }
        ];
      }
      {
        name = "python";
        auto-format = true;
        language-servers = [
          {
            name = "python";
            except-features = [ "format" ];
          }
          {
            name = "ruff-lsp";
            only-features = [ "format" "diagnostics" ];
          }
          # {
          #   name = "ruff-formatter";
          #   only-features = [ "format" ];
          # }
          # "copilot"
        ];
      }
      {
        name = "elm";
        auto-format = true;
        language-servers = [ "elm-lsp" ];
      }
    ];

in
{
  enable = true;
  inherit settings;
  inherit languages;
}
