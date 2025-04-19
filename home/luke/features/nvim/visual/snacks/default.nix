{
  programs.nixvim.plugins.snacks.enable = true;
  imports = [
    ./git.nix
    ./indent.nix
    ./notifier.nix
    ./picker.nix
  ];
}
