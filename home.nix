{ username, pkgs, ... }:

{
  home = {
    inherit username;   

    homeDirectory = "/Users/" + username;
    stateVersion = "23.05";

    packages = with pkgs;
      [
        (rust-bin.stable.latest.default.override { extensions = [ "cargo" "rust-analysis" "rust-src" "rust-std" "rustc" "rust-analyzer" ]; })
        pyenv
        redis
        awscli2
        btop
        # colima
        cowsay
        deno
        difftastic
        # docker
        # docker-compose
        efm-langserver
        elmPackages.elm
        elmPackages.elm-format
        elmPackages.elm-json
        elmPackages.elm-language-server
        elmPackages.elm-review
        elmPackages.elm-test
        erlang
        exercism
        fd
        gh
        git-open
        gleam
        graph-easy
        glow
        hadolint
        jq
        yq
        kubectl
        less
        lsd
        ltex-ls
        marksman
        ncdu
        neovim
        ngrok
        nodePackages."@prisma/language-server"
        nodePackages.bash-language-server
        nodePackages.eslint_d
        nodePackages.fixjson
        nodePackages.graphql-language-service-cli
        nodePackages.markdownlint-cli
        nodePackages.mermaid-cli
        nodePackages.pnpm
        nodePackages.prettier
        nodePackages.typescript-language-server
        nodePackages.yaml-language-server
        nodePackages.yarn
        nodePackages_latest.vscode-langservers-extracted
        nodejs-18_x
        pgformatter
        pipenv
        nixd
        rubyPackages_3_1.rubocop
        rubyPackages_3_1.solargraph
        ruby_3_1
        slides
        taplo
        tmate
        tree
        tree-sitter
        wget
        yazi
        zellij
      ];

    sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
      # DOCKER_HOST = "unix://$HOME/.colima/docker.sock";
      AWS_SDK_JS_SUPPRESS_MAINTENANCE_MODE_MESSAGE = "1";
    };

    sessionPath = [
      "$HOME/.cargo/bin"
      "$HOME/.local/bin"
    ];

    shellAliases =
      {
        c = "cd ~/.config/nixpkgs";
        cdr = "alias gitroot='cd $(git rev-parse --show-toplevel)'";
        ga = "git add";
        gc = "git commit";
        gca = "git commit -v -a";
        gco = "git checkout";
        gd = "git diff";
        ggpull = "git pull";
        ggpush = "git push";
        gs = "git status";
        gwa = "git wf abort";
        gwd = "git wf done";
        gwp = "git wf pr";
        gws = "git wf start";
        h = "hx";
        k = "kubectl";
        ls = "lsd";
        nci = "npm ci";
        ns = "npm start";
        s = "kitty +kitten ssh";
      };
  };

  programs.helix = import ./programs/helix.nix;

  programs.home-manager.enable = true;

  programs.lazygit =
    {
      enable = true;
      settings = {
        os = {
          edit = "/Users/aotarola/.nix-profile/bin/hx -- {{filename}}";
          editAtLine = "/Users/aotarola/.nix-profile/bin/hx -- {{filename}}:{{line}}";
          editAtLineAndWait = "/Users/aotarola/.nix-profile/bin/hx -- {{filename}}:{{line}}";
          editInTerminal = true;
        };
      };
    };

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
    userName = "Andres Otarola";
    userEmail = "andres@otarola.me";
    aliases = {
      prettylog = "...";
    };
    difftastic = {
      enable = true;
    };
    extraConfig = {
      core = {
        editor = "hx";
        excludesfile = "~/.gitignore";
      };
      alias = {
        amend = "commit -a --amend --no-edit";
        r = "remote --verbose";
        repo = "open";
        dft = "difftool";
      };
      color = {
        ui = true;
      };
      push = {
        autoSetupRemote = true;
      };
      pull = {
        rebase = true;
      };
      fetch = {
        prune = true;
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
}
