{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Touchpad
  boot.kernelParams = ["psmouse.synaptics_intertouch=0"];
  services.libinput.enable = true;

  # Logind
  services.logind.settings.Login = {
    HandleLidSwitch = "hibernate";
    HandleLidSwitchExternalPower = "ignore";
    HandlePowerKey = "hibernate";
  };

  # Battery
  powerManagement.enable = true;

  # Network
  networking = {
    hostName = "nixos";
    nftables.enable = true;

    networkmanager.enable = false;
    wireless.enable = false;
    wireless.iwd.enable = true;

    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
    ];

    firewall = {
      enable = true;

      allowedTCPPorts = [
        53317 # localsend: https://forums.linuxmint.com/viewtopic.php?t=408601
      ];
      allowedUDPPorts = [
        53317
      ];
    };

    wg-quick.interfaces = {
      dropp = {
        autostart = false;
        address = ["172.26.230.5/24"];
        dns = ["10.128.0.2"];
        privateKeyFile = "/etc/wireguard/dropp-private.key";

        table = "51820";
        postUp = ''
          ip rule add to 172.26.230.0/24 lookup 51820 prio 100
          ip rule add to 10.127.0.0/16 lookup 51820 prio 100
          ip rule add to 10.128.0.0/23 lookup 51820 prio 100
          ip rule add to 10.129.0.0/24 lookup 51820 prio 100
          ip rule add to 10.130.0.0/24 lookup 51820 prio 100
          ip rule add to 192.168.21.0/24 lookup 51820 prio 100
          ip rule add to 192.168.22.0/24 lookup 51820 prio 100
          ip rule add to 192.168.24.0/24 lookup 51820 prio 100
        '';
        postDown = ''
          ip rule del to 172.26.230.0/24 lookup 51820 prio 100 2>/dev/null || true
          ip rule del to 10.127.0.0/16 lookup 51820 prio 100 2>/dev/null || true
          ip rule del to 10.128.0.0/23 lookup 51820 prio 100 2>/dev/null || true
          ip rule del to 10.129.0.0/24 lookup 51820 prio 100 2>/dev/null || true
          ip rule del to 10.130.0.0/24 lookup 51820 prio 100 2>/dev/null || true
          ip rule del to 192.168.21.0/24 lookup 51820 prio 100 2>/dev/null || true
          ip rule del to 192.168.22.0/24 lookup 51820 prio 100 2>/dev/null || true
          ip rule del to 192.168.24.0/24 lookup 51820 prio 100 2>/dev/null || true
        '';

        peers = [
          {
            publicKey = "Ma3gcXMHNusvKfKCnqggeqxKBrvKtWnxvF4xb+tU5lw=";
            presharedKeyFile = "/etc/wireguard/dropp-preshared.key";
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
            persistentKeepalive = 0;
          }
        ];
      };
    };
  };

  services.dnsmasq = {
    enable = true;
    settings.interface = "dropp";
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  services.blueman.enable = true;

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;

    pulse.enable = true;
  };

  # Locale
  time.timeZone = "Asia/Novosibirsk";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Autologin
  services.getty.autologinUser = "ysomad";

  users.users.ysomad = {
    isNormalUser = true;
    description = "Aleksei Malykh";
    extraGroups = ["network" "audio" "wheel"];
    packages = [];
  };

  # Themes
  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = ../themes/no-clown-fiesta.yaml;
    cursor = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 24;
    };
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.blex-mono;
        name = "BlexMono Nerd Font";
      };
    };
  };

  environment.variables = {
    EDITOR = "nvim";
    TERMINAL = "foot";
    TERM = "foot";
    BROWSER = "firefox-beta";

    # hyprland
    NIXOS_OZONE_WL = "1";
  };

  # Remaps
  hardware.keyboard.qmk.enable = false;
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
    libinput
    powertop

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
    yamlfmt
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
    ani-cli

    # Emails
    thunderbird

    # API clients
    insomnia
    # postman

    # VPN / Proxy
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

    # Wayland
    hyprland
    waybar
    wbg

    # Notifications
    libnotify
    mako

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
    loginShellInit = ''
      if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec Hyprland
      fi
    '';
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles";
      cleanup = "sudo nix-collect-garbage -d";
      upgrade = "sudo nixos-rebuild switch --upgrade --flake ~/dotfiles";
      monitors = "hyprctl monitors all";
      wg-dropp = "~/dotfiles/nix/scripts/wg-dropp";
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
      plugins = ["git" "sudo"];
      theme = "robbyrussell";
    };
  };

  programs.foot = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-tty;
    settings = {
      default-cache-ttl = 28800;
      default-cache-ttl-ssh = 28800;
      max-cache-ttl = 28800;
      max-cache-ttl-ssh = 28800;
    };
  };

  programs.zoxide.enable = true;

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
