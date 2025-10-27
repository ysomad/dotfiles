{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # manage secrets
  sops = {
    defaultSopsFile = ./secrets/default.yaml;
    age.keyFile = "/home/ysomad/.config/sops/age/keys.txt";
    age.generateKey = true;
    secrets.dropp-private = {
      sopsFile = ./secrets/wireguard.yaml;
    };
    secrets.dropp-preshared = {
      sopsFile = ./secrets/wireguard.yaml;
    };
  };

  networking = {
    hostName = "nixos";
    nameservers = ["8.8.8.8" "8.8.4.4"];

    firewall = {
      enable = true;

      # localsend: https://forums.linuxmint.com/viewtopic.php?t=408601
      allowedTCPPorts = [53317];
      allowedUDPPorts = [53317 51820];
    };

    networkmanager.enable = false;
    wireless.enable = false;
    wireless.iwd.enable = true;

    wg-quick.interfaces = {
      dropp = {
        address = ["172.26.230.5/24"];
        dns = ["10.128.0.2"];
        privateKeyFile = config.sops.secrets.dropp-private.path;
        peers = [
          {
            publicKey = "Ma3gcXMHNusvKfKCnqggeqxKBrvKtWnxvF4xb+tU5lw=";
            presharedKeyFile = config.sops.secrets.dropp-preshared.path;
            allowedIPs = [
              "172.26.230.0/24"
              "10.127.0.0/16"
              "10.128.0.0/23"
              "10.129.0.0/24"
              "10.130.0.0/24"
              "192.168.21.0/24"
              "192.168.22.0/24"
              "192.168.24.0/24"
            ];
            endpoint = "wgvpn.dropp.market:51820";
            persistentKeepalive = 25;
          }
        ];
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

  time.timeZone = "Asia/Novosibirsk";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users.ysomad = {
    isNormalUser = true;
    description = "Aleksei Malykh";
    extraGroups = ["audio" "wheel"];
    packages = [];
  };

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/classic-dark.yaml";
  };

  environment.variables = {
    EDITOR = "nvim";
    TERMINAL = "foot";
    TERM = "foot";
    BROWSER = "firefox-beta";

    # hyprland
    NIXOS_OZONE_WL = "1";
  };

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = ["0001:0001"]; # Built-in AT keyboard (PS/2)
      settings = {
        main = {
          capslock = "layer(control)";
          backslash = "backspace";
          backspace = "backslash";
        };
      };
    };
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
    kitty
    foot

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
    vscode
    zed

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
    obs-studio

    # Emails
    thunderbird

    # API clients
    insomnia
    # postman

    # VPN / Proxy
    wireguard-tools
    clash-verge-rev

    # Torrents
    transmission_4-gtk

    # Images
    gimp
    feh

    # Secrets
    keepassxc

    # App launcher
    wofi

    # File manager
    nautilus

    # Hypr
    hyprland
    waybar

    # Google drive mount
    rclone

    # documents
    libreoffice
  ];

  fonts = {
    packages = with pkgs; [
      noto-fonts
      font-awesome
      nerd-fonts.blex-mono
    ];
  };

  # Shell
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [zsh];

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

  programs.foot = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-tty;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.clash-verge = {
    enable = true;
    serviceMode = true;
    tunMode = true;
  };

  system.stateVersion = "25.05";
}
