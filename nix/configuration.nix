{
  pkgs,
  outputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.overlays = [
    # Add overlays your own flake exports (from overlays and pkgs dir):
    outputs.overlays.modifications
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Locale
  time.timeZone = "Asia/Novosibirsk";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Inputs
  services.libinput.enable = true; # required for touchpad support
  boot.kernelParams = ["usbcore.autosuspend=120"]; # autosusped usd devices after 2 min

  # Autologin
  services.getty.autologinUser = "ysomad";

  users.users.ysomad = {
    isNormalUser = true;
    description = "Aleksei Malykh";
    extraGroups = ["network" "audio" "wheel"];
    packages = [];
  };

  # Logind
  services.logind.settings.Login = {
    HandleLidSwitch = "hibernate";
    HandleLidSwitchExternalPower = "ignore";
    HandlePowerKey = "hibernate";
  };

  # Power management
  powerManagement.powertop.enable = true;
  services = {
    power-profiles-daemon.enable = false;
    thermald.enable = false;

    system76-scheduler.settings.cfsProfiles.enable = true;

    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        CPU_BOOST_ON_AC = 0; # disable coz its getting kinda hot
        CPU_BOOST_ON_BAT = 0;

        CPU_MIN_PERF_ON_AC = 20;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 20;
        CPU_MAX_PERF_ON_BAT = 20;

        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };
  };

  # Network
  networking = {
    hostName = "nixos";

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
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true; # TODO: enable it only if HDMI is connected

    # https://wiki.nixos.org/wiki/Bluetooth
    settings = {
      General = {
        # show battery of bluetooth devices
        Experimental = true;
      };
    };
  };
  services.blueman.enable = true;

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  # Themes
  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = ../themes/no-clown-fiesta.yaml;
    cursor = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors";
      size = 30;
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

    # Shells / Terminals
    kitty
    foot
    fish
    starship
    atuin # shell history

    # DB
    dbeaver-bin

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
    gci
    goose
    golangci-lint
    go-swagger

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
    zapret
    clash-verge-rev
    nekoray

    # Torrents
    transmission_4-gtk

    # Images
    gimp
    feh

    # Secrets
    keepassxc

    # App launcher
    fuzzel

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
    libreoffice-qt
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

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.zapret = {
    enable = false;

    # https://github.com/bol-van/zapret/discussions/1594
    # https://github.com/bol-van/zapret/issues/623
    params = [
      "--dpi-desync=fake,disorder2"
      "--dpi-desync-ttl=1"
      "--dpi-desync-autottl=2"
    ];

    # https://github.com/Flowseal/zapret-discord-youtube/blob/main/lists/list-general.txt
    whitelist = [
      "cloudflare-ech.com"
      "encryptedsni.com"
      "cloudflareaccess.com"
      "cloudflareapps.com"
      "cloudflarebolt.com"
      "cloudflareclient.com"
      "cloudflareinsights.com"
      "cloudflareok.com"
      "cloudflarepartners.com"
      "cloudflareportal.com"
      "cloudflarepreview.com"
      "cloudflareresolve.com"
      "cloudflaressl.com"
      "cloudflarestatus.com"
      "cloudflarestorage.com"
      "cloudflarestream.com"
      "cloudflaretest.com"
      "dis.gd"
      "discord-attachments-uploads-prd.storage.googleapis.com"
      "discord.app"
      "discord.co"
      "discord.com"
      "discord.design"
      "discord.dev"
      "discord.gift"
      "discord.gifts"
      "discord.gg"
      "discord.media"
      "discord.new"
      "discord.store"
      "discord.status"
      "discord-activities.com"
      "discordactivities.com"
      "discordapp.com"
      "discordapp.net"
      "discordcdn.com"
      "discordmerch.com"
      "discordpartygames.com"
      "discordsays.com"
      "discordsez.com"
      "frankerfacez.com"
      "ffzap.com"
      "betterttv.net"
      "7tv.app"
      "7tv.io"
      "yt3.ggpht.com"
      "yt4.ggpht.com"
      "yt3.googleusercontent.com"
      "googlevideo.com"
      "jnn-pa.googleapis.com"
      "stable.dl2.discordapp.net"
      "wide-youtube.l.google.com"
      "youtube-nocookie.com"
      "youtube-ui.l.google.com"
      "youtube.com"
      "youtubeembeddedplayer.googleapis.com"
      "youtubekids.com"
      "youtubei.googleapis.com"
      "youtu.be"
      "yt-video-upload.l.google.com"
      "ytimg.com"
      "ytimg.l.google.com"
    ];
  };

  programs.clash-verge = {
    enable = true;
    serviceMode = true;
    tunMode = true;
  };

  programs.nekoray = {
    enable = true;
    tunMode = {
      enable = true;
      setuid = true;
    };
  };

  system.stateVersion = "25.05";
}
