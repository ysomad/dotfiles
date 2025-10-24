# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Enable networking
  networking.networkmanager.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Battery
  powerManagement.enable = true;

  # Touchpad
  # services.libunput.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Novosibirsk";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,ru";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ysomad = {
    isNormalUser = true;
    description = "Aleksei Malykh";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [];
  };

  # Shell
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [zsh];

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Sound
    #pavucontrol
    #easyeffects
    #wiremix

    # Git
    git
    #lazygit

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

    # DB
    #dbeaver-bin
    #libpq

    # Containers
    #podman
    #podman-compose
    # lazydocker

    # AI
    #claude-code

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
    # gci
    goose
    golangci-lint
    # go-swagger

    # Python
    python3
    uv
    black
    isort

    # Lua
    luarocks
    stylua

    # JS
    #nodejs_24

    # Shells / Terminals
    zsh
    # zsh-syntax-highlighting
    # zsh-autosuggestions
    ghostty

    # Browsers
    firefox-beta
    chromium

    # Messengers
    #telegram-desktop
    # slack

    # Video
    mpv
    #obs-studio

    # Emails
    #thunderbird

    # API clients
    # insomnia
    # postman

    # ssh
    gnupg
    pinentry-tty
    keychain

    # VPN / Proxy
    #wireguard-ui
    #v2raya
    #v2rayn
    #nekoray

    # Torrents
    #transmission_4-gtk

    # Archives
    zip
    unzip

    # Images
    #gimp
    #feh
    #gthumb

    # Passwords
    #keepass
    #keepassxc

    # Network
    #networkmanagerapplet
    #iw
    #localsend

    # Screenshots
    #satty # annotations
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

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
