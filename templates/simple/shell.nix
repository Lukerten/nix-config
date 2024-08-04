{
  pkgs ? (let
    inherit (builtins) fetchTree fromJSON readFile;
    inherit ((fromJSON (readFile ./flake.lock)).nodes) nixpkgs;
  in
    import (fetchTree nixpkgs.locked) {}),
}:
pkgs.mkShell {
  hardeningDisable = ["all"];
  name = "C-Env";
  buildInputs = with pkgs; [
    gnumake

    clang-tools
  ];

  shellHook = "";
}
