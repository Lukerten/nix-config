{
  # List your module files here
  # my-module = import ./my-module.nix;

  programs = import ./programs;
  services = import ./services;
  system = import ./system;
}
