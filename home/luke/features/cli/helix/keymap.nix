{
  config,
  pkgs,
  ...
}: {
  programs.helix.settings.keys = {
    normal = {
      H = "extend_char_left";
      x = "extend_to_line_bounds";
      J = ["extend_line_down" "extend_to_line_bounds"];
      K = ["extend_line_up" "extend_to_line_bounds"];
      L = "extend_char_right";
      B = "extend_prev_word_start";
      W = "extend_next_word_start";
      E = "extend_next_word_end";
      A-b = "move_prev_long_word_start";
      A-B = "extend_prev_long_word_start";
      A-w = "move_next_long_word_start";
      A-W = "extend_next_long_word_start";
      A-e = "move_next_long_word_end";
      A-E = "extend_next_long_word_end";
      T = "extend_till_char";
      F = "extend_next_char";
      A-t = "till_prev_char";
      A-f = "find_prev_char";
      A-T = "extend_till_prev_char";
      A-F = "extend_prev_char";
      A-j = "join_selections";
      A-k = "keep_selections";
      M = ["select_mode" "match_brackets" "normal_mode"];
      "#" = "toggle_comments";
      A-l = "extend_to_line_end";
      A-h = "extend_to_line_start";
      left = "goto_previous_buffer";
      right = "goto_next_buffer";
      A-d = "delete_selection";
      c = "change_selection_noyank";
      d = "delete_selection_noyank";
      N = "extend_search_next";
      A-n = "search_prev";
      A-N = "extend_search_prev";
      C-d = ["page_cursor_half_down" "align_view_center"];
      C-u = ["page_cursor_half_up" "align_view_center"];
      tab = "move_parent_node_end";
      S-tab = "move_parent_node_start";

      G = {
        j = "@vgj<esc>";
        k = "@vgk<esc>";
      };

      g = {
        j = "goto_last_line";
        k = "goto_file_start";
      };

      space = {
        c = ":buffer-close";
        A-f = ":toggle auto-format";
        q = ":write-quit-all";
        Q = ":quit!";
        e = ":config-open";
        w = ":write";
        "." = ":toggle file-picker.git-ignore";
        space = "file_picker";
      };
    };

    insert = {
      C-u = ["extend_to_line_bounds" "delete_selection_noyank" "open_above"];
      C-w = ["move_prev_word_start" "delete_selection_noyank"];
      C-space = "completion";
      S-tab = "move_parent_node_start";
    };

    select = {
      tab = "extend_parent_node_end";
      S-tab = "extend_parent_node_start";

      g = {
        j = "goto_last_line";
        k = "goto_file_start";
      };
    };
  };
}
