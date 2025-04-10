{ username, pkgs, ... }:

{
  home = {
    inherit username;   

    homeDirectory = "/Users/" + username;
    stateVersion = "23.05";

    packages = with pkgs;
      [
        (rust-bin.stable.latest.default.override { extensions = [ "cargo" "rust-analysis" "rust-src" "rust-std" "rustc" "rust-analyzer" ]; })
        asdf-vm
        redis
        awscli2
        graphviz
        btop
        gopls
        colima
        cowsay
        deno
        parallel
        difftastic
        docker
        docker-compose
        efm-langserver
        erlang
        exercism
        fd
        gh
        git-open
        gleam
        graph-easy
        glow
        go-task
        golangci-lint-langserver
        # golangci-lint
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
        nodePackages."@prisma/language-server"
        nodePackages.bash-language-server
        nodePackages.fixjson
        nodePackages.markdownlint-cli
        nodePackages.mermaid-cli
        nodePackages.prettier
        nodePackages.typescript-language-server
        nodePackages.yaml-language-server
        nodePackages.yarn
        nodePackages_latest.vscode-langservers-extracted
        opam
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
      ];

    sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
      # DOCKER_HOST = "unix://$HOME/.colima/docker.sock";
      ELM_HOME="$HOME/.local/elm";
      PNPM_HOME = "$HOME/.local/pnpm";
      AWS_SDK_JS_SUPPRESS_MAINTENANCE_MODE_MESSAGE = "1";
    };

    sessionPath = [
      "$HOME/.cargo/bin"
      "$HOME/.local/bin"
      "$HOME/.local/pnpm"
      "$HOME/.local/elm"
      "/Applications/Postgres.app/Contents/Versions/latest/bin"
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
        { name = "mafredri/zsh-async"; tags = [ "from:github" ]; }
        { name = "sindresorhus/pure"; tags = [ "use:pure.zsh" "from:github" "as:theme" ]; }
      ];

    };

    initExtra = ''
    . "${pkgs.asdf-vm}/share/asdf-vm/asdf.sh"
    autoload -Uz bashcompinit && bashcompinit
    . "${pkgs.asdf-vm}/share/asdf-vm/completions/asdf.bash"
    # eval $(opam env --switch=default --set-switch)
    '';

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
