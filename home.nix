{ username, pkgs, unstablePkgs, ... }:

{
  home = {
    inherit username;   

    homeDirectory = "/Users/" + username;
    stateVersion = "23.05";

    packages = with pkgs;
      [
        aichat
        asdf-vm
        redis
        awscli2
        graphviz
        btop
        colima
        cowsay
        parallel
        difftastic
        docker
        docker-compose
        efm-langserver
        exercism
        fd
        gh
        git-open
        graph-easy
        glow
        hadolint
        jq
        yq
        unstablePkgs.kubectl
        unstablePkgs.minikube
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
        pgformatter
        pipenv
        nixd
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
      ELM_HOME="$HOME/.local/elm";
      PNPM_HOME = "$HOME/.local/pnpm";
      # DOCKER_HOST = "unix://$HOME/.colima/docker.sock";
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
        ai = "aichat -e ";
        c = "cd ~/.config/nixpkgs";
        cdr = "cd $(git rev-parse --show-toplevel)";
        ga = "git add";
        gc = "git commit";
        gca = "git commit -v -a";
        gco = "git checkout";
        gd = "git diff";
        ggpull = "git pull";
        ggpush = "git push";
        gox = "go run .";
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
        sync = "!git switch main && git pull --prune && git branch --format '%(refname:short) %(upstream:track)' | awk '$2 == \"[gone]\" { print $1 }' | xargs -r git branch -D";
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
