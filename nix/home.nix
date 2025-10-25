{
  config,
  pkgs,
  ...
}: {
  home.username = "ysomad";
  home.homeDirectory = "/home/ysomad";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [];

  home.file = {
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
    ".config/ghostty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/ghostty";
    ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/hypr";
    ".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/waybar";
  };

  home.sessionVariables = {};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  gtk.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles";
      cleanup = "sudo nix-collect-garbage -d";
      upgrade = "sudo nixos-rebuild switch --upgrade --flake ~/dotfiles";
      cd = "z";
      ls = "eza";
      sl = "eza";
      la = "eza -la";
      al = "eza -la";
      cat = "bat";
      vim = "nvim";
      vi = "nvim";
    };
    history = {
      expireDuplicatesFirst = true;
      size = 100000;
      save = 100000;
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
      ];
      theme = "robbyrussell";
    };
    initContent = ''
      # Add ssh key to the agent
      eval "$(keychain --eval --nogui -q ${config.home.homeDirectory}/.ssh/id_ed25519)"
    '';
  };

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

  programs.bat = {
    enable = true;
  };

  programs.git = {
    enable = true;
    settings.user = {
      email = "49870662+ysomad@users.noreply.github.com";
      name = "Aleksei Malykh";
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      forwardAgent = true;
    };
  };
  services.ssh-agent.enable = true;

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
  };

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
}
