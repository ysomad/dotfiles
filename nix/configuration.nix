{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "nixos";
    nftables.enable = true;
    stevenblack.enable = true; # hosts file
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

  # Shell
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [zsh];

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

    # Shells / Terminals
    zsh
    # zsh-syntax-highlighting
    # zsh-autosuggestions
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
    v2raya
    v2rayn
    nekoray

    # Torrents
    transmission_4

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
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      font-awesome
      nerd-fonts.blex-mono
    ];
  };

  programs.zsh.enable = true;

  environment.variables = {
    EDITOR = "nvim";
    TERMINAL = "ghostty";
    TERM = "ghostty";
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-tty;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  system.stateVersion = "25.05";
}
