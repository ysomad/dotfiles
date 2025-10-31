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
    DEFAULT_BROWSER = "firefox-beta";
  };

  programs.foot.enable = true;

  programs.fuzzel = {
    enable = true;
    settings = {
      border.radius = 3;
      colors.border = lib.mkForce "727272ee";
    };
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
}
