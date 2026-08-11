{ osConfig, config, pkgs, lib, ... }:
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

    # ??
    # llvmPackages.libcxxClang
    # clang-tools
    pamixer
    pavucontrol
    brightnessctl
    xkb-switch
    gxkb
    networkmanagerapplet
    cbatticon
    pasystray
    nautilus
    feh
    gimp
    qimgv
    picom
    # stalonetray
    # betterlockscreen
    simplescreenrecorder
    imagemagick

    # android-studio-full
    silver-searcher-ng
    xclip
    claude-code
    claude-agent-acp
    duckdb
    # git
    babashka
    # rlwrap
    nerd-fonts.fira-code
    # fira-code-nerdfont
    # roswell
    go
    clojure
    leiningen
    # gcc
    pkg-config
    racket
    platinum-searcher
    fzf
    lsof
    # curl
    tmux
    zig
    ocaml
    dune_3
    opam
    # cmake
    kotlin
    # julia-lts
    purescript
    spago
    beam29Packages.erlang
    beam27Packages.lfe
    rebar3
    # gnumake
    janet
    jpm
    # nodePackages_latest.ts-node
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
    imagemagick
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
    # libvterm
    # glib
    bzip2
    parallel
    # jetbrains.idea-community
    rustup
    bat
    # nnn
    btop
    dig
    keychain
    sqlite
    # tdlib
    xdg-utils
    wsl-open
    nodejs_22
    julia-bin
    python3

    telegram-desktop
    slack
    multimarkdown
    libreoffice-fresh
    zip
    # libev
    # supercollider_scel
    # supercolliderPlugins.sc3-plugins
    processing
    pass
    opencode
    
    openssl
    dotenv-cli
    fd
    sbcl

    zoom-us
    ghostty

    yarn

    firefox
    # kdePackages.kwayland
    # kdePackages.wayqt
    # aider-chat-with-browser
    # aider-chat-full
    nix-index
    # aider-chat
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

    # dict
    kdePackages.kdecoration
    kdePackages.applet-window-buttons6
  ] ++ (with unstable; [
    # vscode-langservers-extracted
    typescript-language-server
    yaml-language-server
    bash-language-server
    jdt-language-server
    zls
    ocamlPackages.lsp
    # cmake-language-server
    clojure-lsp
    kotlin-language-server
    gopls
    marksman
    erlang-language-platform
    metals
    sqls
    pyright
    nixd
    delve
    vscode-js-debug
    gdb
    curl
    vscode-extensions.vadimcn.vscode-lldb
    vscode-langservers-extracted
    texliveFull
    ocamlPackages.earlybird
    ghostscript
    mupdf-headless
    poppler-utils
  ]) ++ (with nixos; [# nixos.vscode-langservers-extracted
    # nixos.openssl
    # nixos.aider-chat-full
    # nixos.gcc
    arandr
    # zoom-us
    albert
    flameshot
    meson
    gnutar
    unzip
    unrar
    llvmPackages.libcxxClang
    rlwrap
    clang-tools
    gnumake
    cmake
    roswell
    vlc
    cmake-language-server
    vivaldi
    vivaldi-ffmpeg-codecs
  ]) # ++ (let
          # ghostty = unstable.ghostty.overrideAttrs (_: {
          #   preBuild = ''
          #         shopt -s globstar
          #         sed -i 's/^const xev = @import("xev");$/const xev = @import("xev").Epoll;/' **/*.zig
          #         shopt -u globstar
          #   '';
          # }); in [ghostty])
  ;

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

  # dconf.enable = true;
  # dconf.settings."org/gnome/desktop/interface" = {
  #   color-scheme = "prefer-dark";
  #   gtk-theme = "Adwaita-dark";
  # };

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
    enableBashIntegration = true;
  };

  programs.ripgrep = {
    enable = true;
    package = unstable.ripgrep;
    arguments = ["--follow" "--hidden"];
  };

  programs.emacs = {
    enable = true;
    package = unstable.emacs; # replace with pkgs.emacs-gtk, or a version provided by the community overlay if desired.
    # defaultEditor = true;
  };

  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.notmuch = {
    enable = true;
    extraConfig = {
      user.name = "Victor Litvintsev";
      user.primary_email = "leetwinski@gmail.com";
    };
    # config.user.name = "Victor Litvintsev";
  };

  programs.lieer = {
    enable = true;
    package = unstable.lieer;
  };

  services.lieer.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user.name = "Victor Litvintsev";
      user.email = "leetwinski@gmail.com";
    };
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

    '';

    bashrcExtra = ''
    export EDITOR="emacsclient"
    export QT_SCALE_FACTOR=1
    export QT_AUTO_SCREEN_SCALE_FACTOR=0
    # export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH:$LD_LIBRARY_PATH
    export PATH=~/.roswell/bin:$PATH
    alias ew="emacsclient -c"
    alias ewq="emacsclient -c ."
    alias ewo="emacsclient -c"

    function e() {
        emacsclient -c -nw "$@"
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
                 splitw -l 14 -c $path ';'\
                 select-pane -t 0 ';'\
                 resize-pane -Z
        else
            tmux select-window -t "$win_num"
        fi
    }

    function ppx() {
        path="$(find /home/leet/dev/projects/ -maxdepth 5 -type d -name '.git' -printf '%h\n' | fzf)"
        if [ -z "$path" ]; then
            echo "project path is not specified"
            return 1
        fi

        ew $path &
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
      edif = "/home/leet/edif.sh";
      emer = "/home/leet/emer.sh";
      edif3 = "/home/leet/edif3.sh";
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

  # home.file.".xinitrc" = { !!
  #   text = ''
  #     # # Disable access control for the current user.
  #     # xhost +SI:localuser:$USER

  #     # # Make Java applications aware this is a non-reparenting window manager.
  #     # export _JAVA_AWT_WM_NONREPARENTING=1

  #     # # Set default cursor.
  #     # # xsetroot -cursor_name left_ptr

  #     # # Set keyboard repeat rate.
  #     # xset r rate 200 60

  #     # export XMODIFIERS=@im=exwm-xim
  #     # export GTK_IM_MODULE=xim
  #     # export QT_IM_MODULE=xim
  #     # export CLUTTER_IM_MODULE=xim
  #     # xrandr --output eDP-1 --mode 1920x1200
  #   '';
  # };

  # qt = {
  #   enable = true;
  #   platformTheme.name = "gtk4";
  # };

  # gtk = {
  #   enable = true;
  #   gtk4.theme = null;
  #   theme = {
  #     name = "Adwaita-dark";
  #     package = pkgs.gnome-themes-extra;
  #   };
  #   iconTheme = {
  #     name = "Papirus-Dark";
  #     package = pkgs.papirus-icon-theme;
  #   };
  # };

  home.file."edif.sh" = {
    executable = true;
    text = ''
    #!/usr/bin/env bash

    if [[ -z "$1" ]] || [[ -z "$2" ]]; then
        echo "no files to diff" >&2
        exit 1
    fi

    emacsclient -c -nw -e "(ediff \"$1\" \"$2\")"
    '';
  };

  home.file."edif3.sh" = {
    executable = true;
    text = ''
    #!/usr/bin/env bash

    if [[ -z "$1" ]] || [[ -z "$2" ]] || [[ -z "$3" ]]; then
        echo "no files to diff" >&2
        exit 1
    fi

    emacsclient -c -nw -e "(ediff3 \"$1\" \"$2\" \"$3\")"
    '';
  };

  home.file."emer.sh" = {
    executable = true;
    text = ''
    #!/usr/bin/env bash

    if [[ -z "$1" ]] || [[ -z "$2" ]]; then
        echo "no files to diff" >&2
        exit 1
    fi

    emacsclient -c -nw -e "(ediff-merge \"$1\" \"$2\")"
    '';
  };
 
  systemd.user.startServices = true;

  services.emacs.enable = true;

  # home.sessionVariables = {
  #   # QT_SCALE_FACTOR = "2";
  #   # QT_AUTO_SCREEN_SCALE_FACTOR = "0";
  #   # GDK_SCALE = "2";
  #   # GDK_DPI_SCALE = "0.5";
  #   # QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  # };

  xresources.properties = {
    "Xft.dpi" = 192;
  };

  # lib.services.dictd = {
  #   enable = true;
  #   # dictdDBs = with unstable; [
  #   #   dictdDBs.eng2rus
  #   #   dictdDBs.wordnet
  #   #   dictdDBs.wiktionary
  #   # ];
  # };
}
