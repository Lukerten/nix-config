{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 10000;
    keyMode = "vi";
    terminal = "screen-256color";
    plugins = with pkgs; [
      tmuxPlugins.cpu
      tmuxPlugins.battery
      tmuxPlugins.net-speed
      tmuxPlugins.better-mouse-mode
    ];
    extraConfig = ''
      # Allow mouse interaction
      set-option -g mouse on

      bind C-e send-keys 'vi .' Enter

      # enable true colors
      set-option -sa terminal-overrides ',*:RGB'
      set-option -ga terminal-overrides ',*:Tc'

      # more space to bottom row
      setw -g pane-border-status top
      setw -g pane-border-format ""
      # TODO set color with color generator
      #set -g pane-active-border-style bg=default,fg=brightblack

      # disable repetition
      set-option -g repeat-time 0

      # renumbers windows once one is killed
      set-option -g renumber-windows on

      # Activity Monitoring
      setw -g monitor-activity off
      set -g visual-activity off

      set-option -g set-titles on
      set-option -g set-titles-string '#T - #W'

      # all input in all panes synchronizes
      bind p set-window-option synchronize-panes

      # only useful if not using NixOS
      #bind r source-file ~/.tmux.conf

      # pane movement shortcuts
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Resize pane shortcuts
      bind -r C-k select-window -t :-
      bind -r C-j select-window -t :+

      bind C-u killp

      # Resize pane shortcuts
      bind -r H resize-pane -L 10
      bind -r J resize-pane -D 10
      bind -r K resize-pane -U 10
      bind -r L resize-pane -R 10

      # split window and fix path for tmux 1.9
      bind n split-window -h -c "#{pane_current_path}"
      bind y split-window -v -c "#{pane_current_path}"


      # Styling
      set -g visual-activity off
      set -g visual-bell off
      set -g visual-silence off
      setw -g monitor-activity off
      set -g bell-action none
      setw -g clock-mode-color color1
      setw -g mode-style 'fg=color1 bg=color18 bold'
      set -g pane-border-style 'fg=color1'
      set -g pane-active-border-style 'fg=color3'

      # statusbar
      setw -g clock-mode-color yellow
      setw -g mode-style 'fg=black bg=red bold'

      # panes
      set -g pane-border-style 'fg=red'
      set -g pane-active-border-style 'fg=yellow'

      # statusbar
      set -g status-position top
      set -g status-justify left
      set -g status-style 'fg=red'

      set -g status-left '#{?client_prefix,#[fg=green],#[fg=red]} '
      set -g status-left-length 10


      set -g status-right-style 'fg=black bg=yellow'
      set -g status-right '#[reverse]#[noreverse]%Y-%m-%d %H:%M#[reverse]#[noreverse]'

      setw -g window-status-current-style 'fg=black bg=red'
      setw -g window-status-current-format '#[reverse]#[noreverse]#I #W #F#[reverse]#[noreverse]'

      setw -g window-status-style 'fg=red bg=black'
      setw -g window-status-separator '|'
      setw -g window-status-format ' #I #[fg=white]#W #[fg=yellow]#F '

      setw -g window-status-bell-style 'fg=yellow bg=red bold'

      # messages
      set -g message-style 'fg=yellow bg=black bold'
    '';
  };
    xdg.desktopEntries = {
      tmux = {
        name = "Tmux";
        genericName = "Terminal Multiplexer";
        comment = "Terminal Multiplexer";
        exec = "tmux";
        icon = "tmux";
        terminal = true;
        type = "Application";
      };
    };
}
