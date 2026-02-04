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
        git-lfs
        graph-easy
        glow
        hadolint
        jq
        yq
        unstablePkgs.kubectl
        less
        lsd
        ltex-ls
        marksman
        ncdu
        neovim
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
        cx = "cargo run";
        bx = "bevy run";
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
        t = "task";
        s = "kitty +kitten ssh";};
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
          "kube-ps1"
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
    
    # Enable kube-ps1 for kubectl context in prompt
    KUBE_PS1_ENABLED=on
    KUBE_PS1_SYMBOL_ENABLE=false
    KUBE_PS1_PREFIX="["
    KUBE_PS1_SUFFIX="]"
    
    # Add kube-ps1 to the right prompt
    RPROMPT='$(kube_ps1)'
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
