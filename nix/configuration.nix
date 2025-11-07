{
  pkgs,
  outputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.kernelParams = [
    "usbcore.autosuspend=120" # autosuspend usbs after 2m
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.overlays = [
    outputs.overlays.modifications
  ];

  # Hibernation
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  boot.resumeDevice = "/dev/disk/by-uuid/922f5dcd-fd26-4857-afff-0254fde0c30e";

  # Locale
  time.timeZone = "Asia/Novosibirsk";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Inputs
  services.libinput.enable = true; # required for touchpad support

  # Autologin
  services.getty.autologinUser = "ysomad";

  users.users.ysomad = {
    isNormalUser = true;
    description = "Aleksei Malykh";
    extraGroups = ["network" "audio" "wheel" "podman"];
    packages = [];
  };

  # Logind
  # https://www.freedesktop.org/software/systemd/man/latest/logind.conf.html
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    HandleLidSwitchExternalPower = "ignore";
    HandlePowerKey = "hibernate";
    HandlePowerKeyLongPress = "poweroff";
  };

  # Power management
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_AC = 0;
      CPU_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 85;
    };
  };

  # Fans
  programs.coolercontrol.enable = true;

  # Network
  networking = {
    hostName = "nixos";
    stevenblack.enable = true;

    # use iwd only
    networkmanager.enable = false;
    wireless.enable = false;
    wireless.iwd.enable = true;

    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
    ];

    firewall = {
      enable = true;

      # required for TUN
      # https://github.com/Sk7Str1p3/dotFiles/blob/9e03b805a02b318c62f0f3ef675ec6e3b7812e2e/system/nixos/modules/network/nekoray/default.nix#L8
      # https://github.com/MatsuriDayo/nekoray/issues/1437
      checkReversePath = "loose";

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

  # to add abillity to enable/disable tunnel using shortcut in hyprland
  security.sudo = {
    enable = true;
    extraRules = [
      {
        users = ["ysomad"];
        commands = [
          {
            command = "/run/current-system/sw/bin/systemctl start wg-quick-*";
            options = ["NOPASSWD"];
          }
          {
            command = "/run/current-system/sw/bin/systemctl stop wg-quick-*";
            options = ["NOPASSWD"];
          }
          {
            command = "/run/current-system/sw/bin/systemctl status wg-quick-*";
            options = ["NOPASSWD"];
          }
        ];
      }
    ];
  };

  # Bluetooth
  hardware.enableAllFirmware = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true; # TODO: enable it only if HDMI is connected
  };
  services.blueman.enable = true;

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
  };

  # Disable ThinkPad microphone LED
  # https://discourse.nixos.org/t/mute-key-indicator-light-is-always-on/39528
  systemd.services.disable-mic-led = {
    description = "Disable microphone LED";
    wantedBy = ["sound.target"];
    after = ["sound.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo off > /sys/class/sound/ctl-led/mic/mode'";
      RemainAfterExit = true;
    };
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
      serif = {
        package = pkgs.ibm-plex;
        name = "IBM Plex Serif";
      };
      sansSerif = {
        package = pkgs.ibm-plex;
        name = "IBM Plex Sans";
      };
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
    BROWSER = "zen-beta";
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
          # hhkd like layout
          capslock = "layer(control)";
          backslash = "backspace";
          backspace = "backslash";
          leftalt = "leftmeta";
          leftmeta = "leftalt";
        };
      };
    };
  };

  # Virtualisation
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Secrets
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # Audio
    pavucontrol

    # Bluetooth
    blueman

    # Network
    impala
    localsend

    # Fans
    coolercontrol.coolercontrold
    coolercontrol.coolercontrol-gui

    # Git
    git
    lazygit

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
    unzip
    tree
    brightnessctl
    libinput
    atuin

    # SSH
    gnupg

    # Shells / Terminals
    kitty
    foot
    fish
    starship

    # DB
    jetbrains.datagrip

    # Virtualisation
    podman
    podman-compose
    lazydocker

    # AI
    claude-code

    # Editors
    neovim
    neovide

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
    gotools
    gofumpt
    golines
    gotests
    gomodifytags
    gci
    goose
    golangci-lint
    go-swagger
    mockgen

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
    firefox
    firefox-beta
    chromium
    zen-browser

    # Messengers
    telegram-desktop
    slack

    # Video
    mpv
    ani-cli

    # Emails
    thunderbird

    # API clients
    insomnia

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
    rofi

    # File manager
    nautilus

    # Wayland
    hyprland
    waybar
    wbg
    hyprshot

    # Notifications
    libnotify
    mako

    # Google drive mount
    rclone

    # documents
    libreoffice
  ];

  fonts.packages = with pkgs; [
    font-awesome
  ];

  # Shell
  users.defaultUserShell = pkgs.fish;
  environment.shells = with pkgs; [fish];

  programs.fish = {
    enable = true;
    loginShellInit = ''
      if [ (tty) = "/dev/tty1" ]
          exec Hyprland
      end
      if test (tty) = "/dev/tty1"
          exec Hyprland
      end
    '';
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles";
      cleanup = "sudo nix-collect-garbage -d";
      upgrade = "sudo nixos-rebuild switch --upgrade --flake ~/dotfiles";
      g = "git";
      cd = "z";
      dc = "z";
      ls = "eza";
      sl = "eza";
      la = "eza -la";
      al = "eza -la";
      cat = "bat";
      ct = "bat";
      vim = "nvim";
      vi = "nvim";
      v = "nvim";
    };
  };

  programs.starship.enable = true;

  programs.foot = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
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

  # https://github.com/NixOS/nixpkgs/issues/457613
  # programs.nekoray = {
  #     enable = true;
  #     tunMode = {
  #       enable = true;
  #       setuid = true;
  #     };
  #   };

  system.stateVersion = "25.05";
}
