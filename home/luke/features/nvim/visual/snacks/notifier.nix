{pkgs, ...}: {
  programs.nixvim.extraPackages = with pkgs; [fd];
  programs.nixvim.plugins.snacks = {
    settings = {
      notifier = {
        enabled = true;
        style = "minimal";
        timeout = 3000;
      };
    };
  };
}
