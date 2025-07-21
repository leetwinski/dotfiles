{ config, pkgs, lib, ... }:
let
  unstable = import <unstable> { };
  nixos = import <nixos> { };
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "leet";
  home.homeDirectory = "/home/leet";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with unstable; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    gnutar
    unzip
    # git
    babashka
    rlwrap
    nerd-fonts.fira-code
    fira-code-nerdfont
    roswell
    go
    clojure
    leiningen
    gcc
    pkg-config
    racket
    silver-searcher
    platinum-searcher
    fzf
    lsof
    # curl
    tmux
    zig
    ocaml
    dune_3
    opam
    cmake
    kotlin
    # julia-lts
    purescript
    spago
    erlang_26
    lfe
    rebar3
    gnumake
    janet
    jpm
    nodePackages_latest.ts-node
    typescript
    bun
    aspell
    aspellDicts.ru
    aspellDicts.en
    aspellDicts.en-science
    aspellDicts.en-computers
    aspellDicts.es

    # maxima
    # wxmaxima
    nyxt

    graphviz
    w3m
    idris2
    scala_3
    jdk21
    maven
    gradle
    mermaid-cli
    svgbob
    gnuplot
    dbeaver-bin
    insomnia
    visualvm
    htop
    ocamlPackages.utop
    tldr
    libtool
    libvterm
    bzip2
    parallel
    # jetbrains.idea-community
    rustup
    bat
    nnn
    btop
    dig
    keychain
    sqlite
    tdlib
    xdg-utils
    wsl-open
    nodejs_22
    julia
    python3Full

    telegram-desktop
    slack

    libreoffice-fresh
    zip
    libev
    # supercollider_scel
    # supercolliderPlugins.sc3-plugins
    processing
    pass
    
    openssl
    dotenv-cli
    fd
    sbcl

    zoom-us
    # ghostty

    yarn
    # kdePackages.kwayland
    # kdePackages.wayqt
    # aider-chat-full
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    kdePackages.kdecoration
    kdePackages.applet-window-buttons6
  ] ++ (with unstable; [
    # vscode-langservers-extracted
    nodePackages_latest.typescript-language-server
    yaml-language-server
    bash-language-server
    jdt-language-server
    zls
    ocamlPackages.lsp
    cmake-language-server
    clojure-lsp
    kotlin-language-server
    gopls
    marksman
    erlang-ls
    metals
    sqls
    pyright
    nixd
    delve
    vscode-js-debug
    gdb
    # openssh
    # vscode-extensions.vadimcn.vscode-lldb
    ocamlPackages.earlybird
  ]) ++ [nixos.vscode-langservers-extracted # nixos.openssl
         nixos.curl
         nixos.vivaldi
         nixos.texliveFull
         nixos.aider-chat-full
        ] ++ (let
          ghostty = unstable.ghostty.overrideAttrs (_: {
            preBuild = ''
                  shopt -s globstar
                  sed -i 's/^const xev = @import("xev");$/const xev = @import("xev").Epoll;/' **/*.zig
                  shopt -u globstar
            '';
          }); in [ghostty]);

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/leet/etc/profile.d/hm-session-vars.sh
  #
  # home.sessionVariables = {
  #   EDITOR = "emacsclient -nw";
  # };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.thefuck = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.eza = {
    enable = true;
    package = unstable.eza;
    icons = "auto";
    git = true;
    enableBashIntegration = true;
  };

  programs.jq = {
    enable = true;
    package = unstable.jq;
  };

  programs.atuin = {
    enable = true;
    package = unstable.atuin;
    enableBashIntegration = true;
  };

  programs.ripgrep = {
    enable = true;
    package = unstable.ripgrep;
    arguments = ["--follow" "--hidden"];
  };

  programs.emacs = {
    enable = true;
    package = nixos.emacs; # replace with pkgs.emacs-gtk, or a version provided by the community overlay if desired.
    # defaultEditor = true;
  };

  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # programs.notmuch = {
  #   enable = true;
  #   config.user.name = "Victor Litvintsev";
  # };

  programs.git = {
    enable = true;
    userName = "Victor Litvintsev";
    userEmail = "leetwinski@gmail.com";
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    # custom settings
    settings = {
      add_newline = true;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = false;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;

    profileExtra = ''
    # SSH_ENV="$HOME/.ssh/agent-environment"

    # function start_agent {
    #   echo "Initialising new SSH agent..."
    #   ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
    #   echo succeeded
    #   chmod 600 "$SSH_ENV"
    #   . "$SSH_ENV" > /dev/null
    # }

    # # Source SSH settings, if applicable

    # if [ -f "$SSH_ENV" ]; then
    #   . "$SSH_ENV" > /dev/null
    #   #ps $SSH_AGENT_PID doesn't work under cywgin
    #   ps -ef | grep $SSH_AGENT_PID | grep ssh-agent$ > /dev/null || {
    #       start_agent;
    #   }
    # else
    #   start_agent;
    # fi
    '';

    bashrcExtra = ''
    
    export EDITOR="emacsclient -nw"

    alias ew="emacsclient -c"

    function e() {
        TERM=xterm-256color emacsclient -c -nw "$@"
    }

    function ff() {
        tmux new-window emacsclient -nw -c "$(fzf)"
    }

    function pp() {
        path="$(find /home/leet/dev/projects/ -maxdepth 5 -type d -name '.git' -printf '%h\n' | fzf)"
        if [ -z "$path" ]; then
            echo "project path is not specified"
            return 1
        fi
        new_name="$(echo $path | awk -F'/' '{print $NF}')"
        win_num="$(tmux list-windows -F '#I #W' | grep -m 1 "\[p\]$new_name\$" | awk '{print $1}')"
        if [ -z "$win_num" ]; then
            tmux neww -c "$path" -n "[p]$new_name" "emacsclient -nw -c $path" ';'\
                 splitw -l 14 -c '#{pane_current_path}' ';'\
                 select-pane -t 0 ';'\
                 resize-pane -Z
        else
            tmux select-window -t "$win_num"
        fi
    }

    if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ -z "$INSIDE_EMACS" ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
      exec tmux
    fi

    if [[ -n "$(uname -r | grep -o WSL2)" ]]; then
      export IS_WSL=1
      export BROWSER=wsl-open
    fi

    [ -n "$EAT_SHELL_INTEGRATION_DIR" ] && \
      source "$EAT_SHELL_INTEGRATION_DIR/bash"

    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
    };
  };

  home.file.".emacs.d" = {
    recursive = true;
    source = /home/leet/dotfiles/.emacs.d;
  };

  home.file.".tmux.conf" = {
    source = /home/leet/dotfiles/.tmux.conf;
  };

  home.file.".config/ghostty/config" = {
    source = /home/leet/dotfiles/.ghostty.conf;
  };
 
  systemd.user.startServices = true;

  services.emacs.enable = true;
}
