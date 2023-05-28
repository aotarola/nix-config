let
  # settings = builtins.fromTOML (builtins.readFile ./../config/helix/config.toml);
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
          ret = ":w";
          T = [ "goto_first_nonwhitespace" "find_till_char" ];
          X = "extend_line_above";
          H = ":buffer-previous";
          L = ":buffer-next";
          D = ":buffer-close-others";
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
      rnix-lsp = {
        command = "rnix-lsp";
      };
    };
  };

  languages.language = [
    {
      name = "nix";
      auto-format = true;
      language-servers = [ "rnix-lsp" ];
    }
  ];

in
{
  enable = true;
  inherit settings;
  inherit languages;
}
