{
  config,
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
    ".config/wpaperd".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/wpaperd";
  };

  home.sessionVariables = {
    # for electron apps
    DEFAULT_BROWSER = "firefox-beta";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = let
      browser = "firefox-beta.desktop";
    in {
      "text/html" = [browser];
      "x-scheme-handler/http" = [browser];
      "x-scheme-handler/https" = [browser];
      "x-scheme-handler/about" = [browser];
      "x-scheme-handler/unknown" = [browser];
      "application/pdf" = [browser];

      "image/png" = ["feh.desktop"];
      "image/jpeg" = ["feh.desktop"];
      "image/gif" = ["feh.desktop"];

      "audio/mpeg" = ["mpv.desktop"];
      "audio/flac" = ["mpv.desktop"];

      "video/mp4" = ["mpv.desktop"];
      "video/quicktime" = ["mpv.desktop"];

      "inode/directory" = ["org.gnome.Nautilus.desktop"];

      "text/markdown" = "nvim.desktop";
      "text/plain" = "nvim.desktop";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  gtk.enable = true;
  qt.enable = true;

  programs.foot.enable = true;
  programs.btop.enable = true;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
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

  stylix.targets.tmux.enable = false;
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    keyMode = "vi";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 100000;
    plugins = with pkgs.tmuxPlugins; [
      yank
      vim-tmux-navigator
      better-mouse-mode
    ];
    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",256color*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      # create windows
      bind c new-window -c "#{pane_current_path}"
      bind-key C command-prompt -p "Name of new window: " "new-window -n '%%'"

      # splits
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      # tmux-yank
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # looks
      set-option -g status-style bg=default
      set -g status-fg colour7
      set-window-option -g window-status-current-style fg=colour1
      set -g status-left "#[fg=colour7][#S] "
      set-window-option -g window-status-format " #I:#W"
      set-window-option -g window-status-current-format "#[fg=colour1, bold] #I:#W"
    '';
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

  # Notifications
  services.mako = {
    enable = true;
    settings = {
      default-timeout = 5000;
      ignore-timeout = false;
    };
  };
}
