{
  imports = [
    # Development
    ./dev/appdev.nix
    ./dev/gamedev.nix
    ./dev/network.nix

    # Games
    ./games/emulators.nix
    ./games/pnp.nix

    # Messagers
    ./messagers/minimal.nix
    ./messagers/full.nix

    # Productivity
    ./productivity/notes.nix
  ];
}
