{pkgs, config,lib, ...}:
{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    newSession = true;
    escapeTime = 0;
    secureSocket = false;
    plugins = with pkgs; [
      tmuxPlugins.cpu
      tmuxPlugins.battery
      tmuxPlugins.net-speed
      tmuxPlugins.better-mouse-mode
    ];
    extraConfig = ''
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      # Keybindings
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
      bind r source-file ~/config/.tmux.conf
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Styling
      set -g visual-activity off
      set -g visual-bell off
      set -g visual-silence off
      setw -g monitor-activity off
      set -g bell-action none
      setw -g clock-mode-colour colour1
      setw -g mode-style 'fg=colour1 bg=colour18 bold'
      set -g pane-border-style 'fg=colour1'
      set -g pane-active-border-style 'fg=colour3'

      # statusbar
      setw -g clock-mode-colour yellow
      setw -g mode-style 'fg=black bg=red bold'

      # panes
      set -g pane-border-style 'fg=red'
      set -g pane-active-border-style 'fg=yellow'

      # statusbar
      set -g status-position bottom
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

  programs.tmate = {
    enable = true;
  };

  home.packages = [
    # Open tmux for current project.
    (pkgs.writeShellApplication {
      name = "pux";
      runtimeInputs = [ pkgs.tmux ];
      text = ''
        PRJ="''$(zoxide query -i)"
        echo "Launching tmux for ''$PRJ"
        set -x
        cd "''$PRJ" && \
          exec tmux -S "''$PRJ".tmux attach
      '';
    })
  ];

  xdg.desktopEntries.tmux = {
    name = "Tmux Session";
    genericName = "Terminal Multiplexer";
    comment = "Terminal Multiplexer";
    exec = "tmux new-session -A -s default";
    icon = "utilities-terminal";
    terminal = true;
    type = "Application";
    categories = ["Utility" "TerminalEmulator"];
  };
}
