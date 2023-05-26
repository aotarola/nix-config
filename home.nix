{ config, pkgs, lib, ... }:

{
  home = {

    packages = with pkgs; [
      (python310.withPackages (ps: with ps; [ python-lsp-server pytest pipx ] ++ python-lsp-server.optional-dependencies.all))
      awscli2
      black
      btop
      colima
      deno
      difftastic
      docker
      docker-compose
      efm-langserver
      elmPackages.elm
      elmPackages.elm-format
      elmPackages.elm-json
      elmPackages.elm-language-server
      elmPackages.elm-test
      erlang
      exercism
      fd
      gh
      git-open
      gleam
      haskellPackages.dhall
      haskellPackages.dhall-lsp-server
      haskellPackages.dhall-toml
      jq
      kubectl
      less
      lsd
      ncdu
      neovim
      nodePackages."@prisma/language-server"
      nodePackages.bash-language-server
      nodePackages.eslint_d
      nodePackages.fixjson
      nodePackages.graphql-language-service-cli
      nodePackages.mermaid-cli
      nodePackages.pnpm
      nodePackages.prettier
      nodePackages.pyright
      nodePackages.serverless
      nodePackages.typescript-language-server
      nodePackages.yaml-language-server
      nodePackages.yarn
      nodePackages_latest.vscode-langservers-extracted
      nodejs-16_x
      pipenv
      rnix-lsp
      rubyPackages_3_1.rubocop
      rubyPackages_3_1.solargraph
      ruby_3_1
      rustup
      taplo
      tree
      tree-sitter
      wget
    ];

    sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
      DOCKER_HOST = "unix://$HOME/.colima/docker.sock";
    };

    sessionPath = [
      "$HOME/.cargo/bin"
      "$HOME/.local/bin"
    ];

    shellAliases =
      {
        c = "cd ~/.config/nixpkgs";
        cdr = "alias gitroot='cd $(git rev-parse --show-toplevel)'";
        ga = "git add .";
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
        hms = "nix profile list | { grep 'home-manager-path$' || test $? = 1; } | awk -F ' ' '{ print $4 }' | cut -d ' ' -f 4 | xargs -t $DRY_RUN_CMD nix profile remove $VERBOSE_ARG && \"$(nix path-info ~/.config/nixpkgs#homeConfigurations.$USER@$(hostname -s).activationPackage)\"/activate";
        k = "kubectl";
        ls = "lsd";
        nci = "npm ci";
        ns = "npm start";
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

  # Example of custom arbitrary dotfile
  xdg.configFile."foo".source = ./dotfiles/foo/config.yaml;
  xdg.configHome.source = ./config/helix;
}
