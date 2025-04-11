{
  programs.nixvim.plugins.notify = {
    enable = true;
    settings = {
      level = "info";
      timeout = 5000;
      max_width = 80;
      max_height = 10;
      background_colour = "#00000000";
      stages = "fade_in_slide_out";
      icons = {
        error = "";
        warn = "";
        info = "";
        debug = "";
        trace = "✎";
      };
      render = "default";
      minimum_width = 50;
      fps = 30;
      top_down = true;
    };
  };
}
