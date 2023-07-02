let
  settings =
    {
      theme = "catppuccin_mocha";
      editor = {
        color-modes = true;
        cursorline = true;
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
          display-messages = false;
          snippets = true;
          auto-signature-help = false;
          display-signature-help-docs = false;
        };

        file-picker = {
          git-ignore = true;
          hidden = true;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        statusline = {
          center = [ "file-name" ];
          left = [ "mode" "spinner" ];
          right = [ "diagnostics" "selections" "position" "file-encoding" "file-line-ending" "file-type" ];
        };
      };

      keys = {
        normal = {
          C-r = [ ":config-reload" ":reload" ];
          esc = [ "collapse_selection" "keep_primary_selection" ];
          ret = ":w";
          X = "extend_line_above";
          H = ":buffer-previous";
          L = ":buffer-next";
          D = ":buffer-close-others";
          G = [ "extend_to_line_bounds" "trim_selections" "change_selection" ];
          d = [ "yank_main_selection_to_clipboard" "normal_mode" "delete_selection" ];
          space = {
            c = ":bc";
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
      };

      rnix = {
        command = "rnix-lsp";
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
              singleQuote = false;
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
          config = { }; # Yes, this is needed 🤷
        };

      elm =
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
              formatCommand = "fixjson";
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
                formatCommand = "black --fast --quiet -";
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
        name = "nix";
        auto-format = true;
        language-servers = [ "rnix" ];
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
            name = "python-formatter";
            only-features = [ "format" ];
          }
          # "copilot"
        ];
      }
      {
        name = "elm";
        auto-format = true;
        language-servers = [ "elm" ];
      }
    ];

in
{
  enable = true;
  inherit settings;
  inherit languages;
}
