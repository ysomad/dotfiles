{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "nixos";
    nftables.enable = true;
    stevenblack.enable = true;
    nameservers = ["8.8.8.8" "8.8.4.4"];

    firewall = {
      enable = true;

      # localsend: https://forums.linuxmint.com/viewtopic.php?t=408601
      allowedTCPPorts = [53317];
      allowedUDPPorts = [53317];
    };

    networkmanager = {
      enable = true;
      wifi = {
        backend = "iwd";
        powersave = true;
      };
    };

    wireless.iwd = {
      enable = true;
      settings = {
        Network.EnableIPv6 = true;
        Settings.AutoConnect = true;
      };
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  services.blueman.enable = true;

  # Audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Battery
  powerManagement.enable = true;
  # powerManagement.powertop.enable = true;
  # services = {
  #   power-profiles-daemon.enable = false;
  #   tlp = {
  #     enable = true;
  #     settings = {
  #       CPU_BOOST_ON_AC = 1;
  #       CPU_BOOST_ON_BAT = 0;
  #       CPU_SCALING_GOVERNOR_ON_AC = "performance";
  #       CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
  #       STOP_CHARGE_THRESH_BAT0 = 95;
  #     };
  #   };
  # };

  time.timeZone = "Asia/Novosibirsk";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users.ysomad = {
    isNormalUser = true;
    description = "Aleksei Malykh";
    extraGroups = ["audio" "networkmanager" "wheel"];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Audio
    pavucontrol

    # Bluetooth
    blueman

    # Network
    impala
    localsend

    # Git
    git
    lazygit

    # ssh
    gnupg
    pinentry-tty
    keychain

    # CLI
    eza
    zoxide
    bat
    wget
    fzf
    fd
    jq
    ripgrep
    gcc
    gnumake
    tmux
    btop
    tree-sitter
    hl-log-viewer
    fastfetch
    unzip
    tree
    brightnessctl

    # Shells / Terminals
    zsh
    ghostty

    # DB
    dbeaver-bin
    libpq

    # Containers
    podman
    podman-compose
    lazydocker

    # AI
    claude-code

    # Editors
    neovim
    # vscode
    # zed

    # LSP
    gopls
    golangci-lint-langserver
    lua-language-server
    pyright
    taplo
    nil

    # Formatters
    beautysh
    yamlfix
    pgformatter
    alejandra # nix

    # Go
    go
    gofumpt
    golines
    # gci # broken for some reason
    goose
    golangci-lint
    # go-swagger # broken for some reason

    # Python
    python3
    uv
    black
    isort

    # Lua
    luarocks
    stylua

    # JS
    nodejs_24

    # Browsers
    firefox-beta
    chromium

    # Messengers
    telegram-desktop
    slack

    # Video
    mpv
    #obs-studio

    # Emails
    thunderbird

    # API clients
    # insomnia
    # postman

    # VPN / Proxy
    wireguard-ui
    # nekoray
    clash-verge-rev

    # Torrents
    transmission_4-gtk

    # Images
    #gimp
    #feh
    #gthumb

    # Secrets
    keepassxc

    # Screenshots
    #satty # annotations

    # App launcher
    wofi

    # File manager
    nautilus

    # Hypr
    kitty
    hyprland
    waybar

    # Google drive mount
    rclone
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      font-awesome
      nerd-fonts.blex-mono
    ];
  };

  # Shell
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [zsh];

  programs.zoxide.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 100000;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles";
      cleanup = "sudo nix-collect-garbage -d";
      upgrade = "sudo nixos-rebuild switch --upgrade --flake ~/dotfiles";
      monitors = "hyprctl monitors all";
      cd = "z";
      ls = "eza";
      sl = "eza";
      la = "eza -la";
      al = "eza -la";
      cat = "bat";
      vim = "nvim";
      vi = "nvim";
    };
    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
      ];
      theme = "robbyrussell";
    };
  };

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = ["*"];
      settings = {
        main = {
          capslock = "layer(control)";
          backslash = "backspace";
          backspace = "backslash";
        };
      };
    };
  };

  environment.variables = {
    EDITOR = "nvim";
    TERMINAL = "ghostty";
    TERM = "xterm-ghostty";
    BROWSER = "firefox-beta";
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # https://discourse.nixos.org/t/nekoray-tun-mode-not-work/68696/2
  # security.wrappers.nekobox_core = {
  #   enable = true;
  #   source = "${pkgs.nekoray.nekobox-core}/bin/nekobox_core";
  #   program = "nekobox_core";
  #   owner = "ysomad";
  #   group = "users";
  #   capabilities = "cap_net_admin=ep";
  # };

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/classic-dark.yaml";
  };

  system.stateVersion = "25.05";
}
