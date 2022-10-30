{ config, pkgs, lib, ... }:

{
  home = {

    packages = with pkgs; [
      lsd
      tree
      nodejs-16_x
      ncdu
      rnix-lsp
      yaml-language-server
      difftastic
      tree-sitter
      fd
      neovim
      pyright
      jq
      wget
      btop
      docker
      docker-compose
      kubectl
      colima
      rustup
      elmPackages.elm-language-server
      git-open
    ];

    sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
    };

    sessionPath = [
      "$HOME/.cargo/bin"
      "$HOME/.local/bin"
    ];

    shellAliases =
      {
        h = "hx";
        gs = "git status";
        gd = "git dft";
        ga = "git add .";
        gca = "git commit -v -a";
        gc = "git commit";
        gco = "git checkout";
        ggpush = "git push";
        ggpull = "git pull";
        hms = "home-manager switch --flake $HOME/.config/nixpkgs#$USER@$(hostname -s)";
        k = "kubectl";
        nci = "npm ci";
        ns = "npm start";
        ls = "lsd";
        ll = "lsd -l";
      };
  };

  programs.home-manager.enable = true;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };


  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    oh-my-zsh =
      {
        enable = true;

        plugins = [
          "vi-mode"
        ];
      };

    zplug = {
      enable = true;
      plugins = [
        { name = "mafredri/zsh-async"; tags = [ from:github ]; }
        { name = "sindresorhus/pure"; tags = [ use:pure.zsh from:github as:theme ]; }
      ];

    };

  };

  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      italic-text = "always";
    };
  };

  programs.git = {
    enable = true;
    userName = "aotarola";
    userEmail = "andres@otarola.me";
    aliases = {
      prettylog = "...";
    };
    extraConfig = {
      core = {
        editor = "hx";
      };
      color = {
        ui = true;
      };
      pull = {
        rebase = true;
      };
      fetch = {
        prune = true;
      };
      pager = {
        difftool = true;
      };
      diff = {
        colorMoved = "zebra";
        tool = "difftastic";
      };
      difftool = {
        cmd = "difft \"$LOCAL\" \"$REMOTE\"";
        prompt = false;
      };
      alias = {
        repo = "open";
      };
      init = {
        defaultBranch = "main";
      };
    };
    ignores = [
      ".DS_Store"
      "*.pyc"
      "*.log"
      "*.pdf"
      "*.orig"
      "*.fls"
      "*.fdb_latexmk"
      "*.gz"
      "*.sublime-project"
      "*.sublime-workspace"
      ".vscode/"
      ".vim/"
      ".vimspector.json"
      ".marksman.toml"
    ];
  };

  # Example of custom arbitrary dotfile
  xdg.configFile."foo".source = ./dotfiles/foo/config.yaml;
}
