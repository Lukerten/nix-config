{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.hyprlauncher;
  defaultConfig = {
    window = {
      width = 600;
      height = 600;
      anchor = "center";
      margin_top = 0;
      margin_bottom = 0;
      margin_left = 0;
      margin_right = 0;
      show_descriptions = false;
      show_paths = false;
      show_icons = true;
      show_search = true;
      show_actions = false;
      show_border = true;
      border_width = 2;
      use_gtk_colors = false;
      use_custom_css = false;
      max_entries = 50;
    };
    theme = {
      colors = {
        border = "#333333";
        window_bg = "#0f0f0f";
        search_bg = "#1f1f1f";
        search_bg_focused = "#282828";
        item_bg = "#0f0f0f";
        item_bg_hover = "#181818";
        item_bg_selected = "#1f1f1f";
        search_text = "#e0e0e0";
        search_caret = "#808080";
        item_name = "#ffffff";
        item_name_selected = "#ffffff";
        item_description = "#a0a0a0";
        item_description_selected = "#a0a0a0";
        item_path = "#808080";
        item_path_selected = "#808080";
      };
      corners = {
        window = 12;
        search = 8;
        list_item = 8;
      };
      spacing = {
        search_margin = 12;
        search_padding = 12;
        item_margin = 6;
        item_padding = 4;
      };
      typography = {
        search_font_size = 16;
        item_name_size = 14;
        item_description_size = 12;
        item_path_size = 12;
        item_path_font_family = "monospace";
      };
    };
    debug = {
      disable_auto_focus = false;
      enable_logging = false;
    };
    dmenu = {
      allow_invalid = false;
      case_sensitive = false;
    };
    web_search = {
      enabled = false;
      engine = "duckduckgo";
      prefixes = [];
    };
    calculator = {
      enabled = false;
    };
  };
in {
  options.programs.hyprlauncher = {
    enable = mkEnableOption "hyprlauncher";

    package = mkOption {
      type = types.package;
      default = pkgs.hyprlauncher;
      description = "The hyprpicker package to use.";
    };

    config = mkOption {
      type = types.attrs;
      default = {};
      description = "Configuration for hyprlauncher.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];
    xdg.configFile."hyprlauncher/config.json".text = builtins.toJSON (defaultConfig // cfg.config);
  };
}
