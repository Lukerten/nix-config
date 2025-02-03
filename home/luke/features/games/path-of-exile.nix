{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    path-of-building
  ];
}
