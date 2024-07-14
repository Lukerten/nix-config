{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      resurrect
      copycat
      open
      urlview
      better-mouse-mode

    ];
    package = pkgs.tmux;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    newSession = false;
    prefix = "C-a";
    extraConfig = ''
      unbind C-b
      bind-key C-a send-prefix

      # define key bindings to swap between sessions
      bind-key S switch-client -l
      bind-key L list-sessions
      bind-key C command-prompt -p "Name of new session: " "new-session -s '%%'"
      bind-key c command-prompt -p "Name of new window: " "new-window -n '%%'"
      bind-key > switch-client -n
      bind-key < switch-client -p

      # define keys to swap between panes
      bind-key -r - split-window -v
      bind-key | split-window -h

      # resize panes
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R
      bind-key H resize-pane -L 5
      bind-key J resize-pane -D 5
      bind-key K resize-pane -U 5
      bind-key L resize-pane -R 5
      bind-key M resize-pane -Z
      bind-key m select-pane -t:.0
    '';
  };

  xdg.desktopEntries = {
    tmux = {
      name = "tmux";
      genericName = "Terminal Multiplexer";
      comment = "Start a terminal with tmux";
      exec = "tmux";
      icon = "utilities-terminal";
      terminal = true;
      type = "Application";
      categories = [ "System" "Utility" "TerminalEmulator" ];
    };
  };
}
