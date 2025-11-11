{
  config,
  lib,
  pkgs,
  ...
}: {
  home.username = "ysomad";
  home.homeDirectory = "/home/ysomad";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = [];

  home.file = {
    ".gitconfig".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.gitconfig";
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
    ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/hypr";
    ".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/waybar";
  };

  programs.home-manager.enable = true;

  home.sessionVariables = {
    # for electron apps
    DEFAULT_BROWSER = "zen-beta";
  };

  programs.foot.enable = true;

  programs.rofi = {
    enable = true;
    plugins = [pkgs.rofi-emoji];
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      set fish_color_command white
      set fish_color_normal white
    '';
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      format = "$directory$git_branch$git_status$cmd_duration";

      directory = {
        truncation_length = 1;
        truncate_to_repo = false;
        format = "[$path](bold cyan) ";
      };

      git_branch = {
        symbol = "";
        format = "[$symbol $branch](bold magenta)";
      };

      git_status = {
        format = "[$all_status$ahead_behind](bold magenta) ";
      };

      cmd_duration = {
        min_time = 1000;
        format = "[$duration](bold bright-black) ";
      };
    };
  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    flags = ["--disable-up-arrow"];
    settings = {
      invert = true;
      show_help = false;
    };
  };

  services.gpg-agent = {
    enable = true;
    enableFishIntegration = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-gnome3;
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      forwardAgent = true;
    };
    extraConfig = ''
      Host *
        AddKeysToAgent yes
        IdentityFile ~/.ssh/id_ed25519
      Host master
        HostName 185.161.251.102
        StrictHostKeyChecking no
        User root
        ForwardAgent yes
        IdentityFile ~/.ssh/id_ed25519
        IdentitiesOnly yes
        AddKeysToAgent yes
        ServerAliveInterval 60
        ServerAliveCountMax 1200
        Port 38671
        LocalForward 1337 localhost:2387
        LocalForward 1488 localhost:6767
      Host de1
        HostName 164.90.242.229
        StrictHostKeyChecking no
        User root
        ForwardAgent yes
        IdentityFile ~/.ssh/id_ed25519
        IdentitiesOnly yes
        AddKeysToAgent yes
        ServerAliveInterval 60
        ServerAliveCountMax 1200
        Port 38671
      Host de2
        HostName 194.87.71.214
        StrictHostKeyChecking no
        User root
        ForwardAgent yes
        IdentityFile ~/.ssh/id_ed25519
        IdentitiesOnly yes
        AddKeysToAgent yes
        ServerAliveInterval 60
        ServerAliveCountMax 1200
        Port 38671
      Host dev-lob
        HostName 10.127.0.71
        StrictHostKeyChecking no
        User www
        ForwardAgent yes
        IdentityFile ~/.ssh/id_ed25519
        IdentitiesOnly yes
        AddKeysToAgent yes
        ServerAliveInterval 60
        ServerAliveCountMax 1200
        Port 22
      Host prod-lob
        HostName 10.128.1.200
        StrictHostKeyChecking no
        User www
        ForwardAgent yes
        IdentityFile ~/.ssh/id_ed25519
        IdentitiesOnly yes
        AddKeysToAgent yes
        ServerAliveInterval 60
        ServerAliveCountMax 1200
        Port 22
    '';
  };

  programs.tmux = {
    enable = true;
    prefix = "C-a";
    keyMode = "vi";
    mouse = true;
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 100000;
    plugins = with pkgs.tmuxPlugins; [
      yank
      vim-tmux-navigator
      better-mouse-mode
    ];
    extraConfig = lib.mkAfter ''
      # simpler colors for active/inactive windows
      set -g window-status-style "fg=#${config.lib.stylix.colors.base03}"
      set -g window-status-current-style "fg=#${config.lib.stylix.colors.base07}"

      # renumber windows automatically
      set-option -g renumber-windows on

      # create windows
      bind c new-window -c "#{pane_current_path}"
      bind-key C command-prompt -p "Name of new window: " "new-window -n '%%'"

      # splits
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %

      # tmux-yank
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
    '';
  };

  programs.btop.enable = true;

  # Notifications
  stylix.targets.mako.enable = true;
  services.mako = {
    enable = true;
    settings = {
      default-timeout = 5000;
      ignore-timeout = false;
    };
  };

  # rclone: mount gdrive
  systemd.user.services.rclone-gdrive-mount = let
    gdriveDir = "${config.home.homeDirectory}/gdrive";
  in {
    Unit = {
      Description = "Mount Google Drive with rclone";
      After = ["network-online.target"];
      Wants = ["network-online.target"];
    };

    Service = {
      Type = "notify";
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${gdriveDir}";
      ExecStart = "${pkgs.rclone}/bin/rclone mount gdrive: ${gdriveDir} --vfs-cache-mode writes --vfs-cache-max-age 24h";
      ExecStop = "${pkgs.fuse}/bin/fusermount -u ${gdriveDir}";
      Restart = "on-failure";
      RestartSec = "10s";
    };

    Install = {
      WantedBy = ["default.target"];
    };
  };

  # bluetooth headset button to control media
  services.mpris-proxy.enable = true;

  # https://github.com/0xc000022070/zen-browser-flake/issues/59#issuecomment-2964607780
  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = [pkgs.firefoxpwa];

    profiles.default = {
      settings = {
        "zen.theme.content-element-separation" = 0;
        "zen.view.compact.animate-sidebar" = false;

        # performance tweaks
        # https://github.com/zen-browser/desktop/issues/6302
        "widget.gtk.rounded-bottom-corners.enabled" = false;
        "zen.theme.gradient" = false;
        "zen.view.experimental-rounded-view" = false;
        "zen.mediacontrols.enabled" = false;
      };

      spacesForce = true;
      spaces = {
        "Personal" = {
          id = "572910e1-4468-4832-a869-0b3a93e2f165";
          icon = "🏠";
          position = 1000;
        };
        "Work" = {
          id = "ec287d7f-d910-4860-b400-513f269dee77";
          icon = "💼";
          position = 1001;
        };
      };
    };

    policies = {
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };
  };

  stylix.targets.zen-browser.enable = false;

  programs.neovide.enable = true;
}
