{
  # List your module files here
  # my-module = import ./my-module.nix;

  hydra-auto-upgrade = import ./hydra-auto.nix;
  cm4all-vpn = import ./cli/cm4all-vpn.nix;
}
