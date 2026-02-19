{ username, pkgs, lib, unstablePkgs, config, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in
{
  home = {
    inherit username;

    homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";
    stateVersion = "23.05";

    packages = with pkgs;
      [
        aichat
        asdf-vm
        redis
        awscli2
        graphviz
        btop
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
      ]
      ++ lib.optionals isDarwin [ colima ]
      ++ lib.optionals isLinux [ xclip ];

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
    ] ++ lib.optionals isDarwin [
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


  programs.helix = import ./programs/helix.nix { inherit isDarwin isLinux config; };

  programs.home-manager.enable = true;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";

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

    initContent = ''
    # asdf-vm setup (0.18.0+ Go version)
    export ASDF_DIR="${pkgs.asdf-vm}"
    export PATH="''${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

    # asdf completions
    autoload -Uz bashcompinit && bashcompinit
    . "${pkgs.asdf-vm}/share/bash-completion/completions/asdf.bash"

    # Enable kube-ps1 for kubectl context in prompt
    KUBE_PS1_ENABLED=on
    KUBE_PS1_SYMBOL_ENABLE=false
    KUBE_PS1_PREFIX="["
    KUBE_PS1_SUFFIX="]"

    # Add kube-ps1 to the right prompt
    RPROMPT='$(kube_ps1)'
    '' + lib.optionalString isDarwin ''
    # Fix /etc/zshrc after macOS updates overwrite nix shell integration
    append_nix_to_zshrc() {
      local source_file="/etc/zshrc.nix-restore"
      local dest_file="/etc/zshrc"

      if [[ ! -f "$source_file" ]]; then
        echo "❌ Error: Source file not found at '$source_file'" >&2
        return 1
      fi

      if [[ -f "$dest_file" ]]; then
        local source_content=$(cat "$source_file")
        local dest_content=$(cat "$dest_file")

        if [[ "$dest_content" == *"$source_content"* ]]; then
          echo "✅ Content already present in '$dest_file'. No action needed."
          return 0
        fi
      fi

      if [[ -f "$dest_file" ]]; then
        local timestamp=$(date +%Y-%m-%d-%H%M%S)
        local backup_file="''${dest_file}.bak-''${timestamp}"

        echo "Backing up current '$dest_file' to '$backup_file'..."
        sudo cp "$dest_file" "$backup_file"
        if [[ $? -ne 0 ]]; then
            echo "❌ Error: Backup failed. Aborting." >&2
            return 1
        fi
      fi

      echo "Appending content from '$source_file' to '$dest_file'..."
      cat "$source_file" | sudo tee -a "$dest_file" > /dev/null

      echo "🚀 Append complete."
    }

    alias fix_zshrc=append_nix_to_zshrc
    '';

  };

  programs.ghostty = {
    enable = true;
    package = if isDarwin then null else pkgs.ghostty;
    enableZshIntegration = true;
    settings = {
      theme = "Dracula";
      font-family = "JetBrainsMono Nerd Font Medium";
      font-family-bold = "JetBrainsMono Nerd Font Bold";
      font-family-italic = "JetBrainsMono Nerd Font Italic";
      font-family-bold-italic = "JetBrainsMono Nerd Font Bold Italic";
      font-size = 17;
      cursor-style-blink = false;
      font-thicken = true;
      font-thicken-strength = 255;
      window-padding-x = 10;
      window-padding-y = 10;
      window-save-state = "never";
      macos-option-as-alt = true;
      shell-integration-features = "no-cursor,no-sudo,title";
      keybind = [
        "super+left=previous_tab"
        "super+right=next_tab"
        "cmd+l=new_split:right"
        "super+k=goto_split:previous"
        "super+j=goto_split:next"
        "super+shift+f=toggle_split_zoom"
        "super+enter=new_split:down"
        "super+x=close_window"
        "super+o=clear_screen"
        "shift+enter=text:\\n"
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

  programs.difftastic = {
    enable = true;
    git.enable = true;
  };

  programs.git = {
    enable = true;
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
    settings = {
      user = {
        name = "Andres Otarola";
        email = "andres@otarola.me";
      };
      alias = {
        prettylog = "...";
        amend = "commit -a --amend --no-edit";
        r = "remote --verbose";
        repo = "open";
        dft = "difftool";
        sync = "!git switch main && git pull --prune && git branch --format '%(refname:short) %(upstream:track)' | awk '$2 == \"[gone]\" { print $1 }' | xargs -r git branch -D";
      };
      core = {
        editor = "hx";
        excludesfile = "~/.gitignore";
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
  };
}
