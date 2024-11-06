{
  lib,
  config,
  ...
}: {
  programs.fish = let
    hasEza = lib.mkIf config.programs.eza.enable;
    hasNeovim = config.programs.neovim.enable;
    hasRipgrep = config.programs.ripgrep.enable;
    inherit (lib) mkIf;
  in {
    enable = true;
    shellAbbrs =
      config.home.shellAliases
      // {
        ls = hasEza "exa";
        la = hasEza "exa -la";
        ll = hasEza "exa -l";
        lla = hasEza "exa -la";
      };
    functions = {
      fish_greeting = "";
      nvimrg = mkIf (hasNeovim && hasRipgrep) "nvim -q (rg --vimgrep $argv | psub)";
      up-or-search = lib.readFile ./up-or-search.fish;
      nix-inspect =
        /*
        fish
        */
        ''
          set -s PATH | grep "PATH\[.*/nix/store" | cut -d '|' -f2 |  grep -v -e "-man" -e "-terminfo" | perl -pe 's:^/nix/store/\w{32}-([^/]*)/bin$:\1:' | sort | uniq
        '';
    };
    interactiveShellInit =
      /*
      fish
      */
      ''
        bind \ee edit_command_buffer

        # Use vim bindings and cursors
        fish_vi_key_bindings
        set fish_cursor_default     block      blink
        set fish_cursor_insert      line       blink
        set fish_cursor_replace_one underscore blink
        set fish_cursor_visual      block

        # Use terminal colors
        set -x fish_color_autosuggestion      brblack
        set -x fish_color_cancel              -r
        set -x fish_color_command             brgreen
        set -x fish_color_comment             brmagenta
        set -x fish_color_cwd                 green
        set -x fish_color_cwd_root            red
        set -x fish_color_end                 brmagenta
        set -x fish_color_error               brred
        set -x fish_color_escape              brcyan
        set -x fish_color_history_current     --bold
        set -x fish_color_host                normal
        set -x fish_color_host_remote         yellow
        set -x fish_color_match               --background=brblue
        set -x fish_color_normal              normal
        set -x fish_color_operator            cyan
        set -x fish_color_param               brblue
        set -x fish_color_quote               yellow
        set -x fish_color_redirection         bryellow
        set -x fish_color_search_match        'bryellow' '--background=brblack'
        set -x fish_color_selection           'white' '--bold' '--background=brblack'
        set -x fish_color_status              red
        set -x fish_color_user                brgreen
        set -x fish_color_valid_path          --underline
        set -x fish_pager_color_completion    normal
        set -x fish_pager_color_description   yellow
        set -x fish_pager_color_prefix        'white' '--bold' '--underline'
        set -x fish_pager_color_progress      'brwhite' '--background=cyan'
      '';
  };
}
