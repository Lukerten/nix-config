[![built with nix](https://img.shields.io/static/v1?logo=nixos&logoColor=white&label=&message=Built%20with%20Nix&color=41439a)](https://builtwithnix.org)

# Lukes NixOS configuration
This is my personal NixOS configuration. Requires [Nix flakes](https://nixos.wiki/wiki/Flakes). \\
This Config is heavily based on the Work of [Misterio77](https://github.com/Misterio77). \\

## Structure:
- `home`- Contains home-manager configuration.
- `hosts` - Contains the configuration for the different systems.
- `modules` - Contains the configuration for different services.
  - `nixos` - Extends the Nixos Module base.
  - `home-manager` - Extends the Home-Manager Module base.
- `overlays` - Different package overlays.
- `pkgs` - Custom packages.
- `templates` - Templates for different projects.
- `flake.nix` - The entry point for the flake.
- `hydra.nix` - Hydra configuration.
- `shell.nix` - The shell configuration.

# My Hosts:
Currently this configuration only powers 2 desktop systems, as i am focusing on completing these before moving on to other systems. \\
- `anihilaton` - My Home Laptop.
- `exaflare` - My Home Desktop.

# Secrets
This Project uses [Mic92/sops-nix](https://github.com/Mic92/sops-nix) for provisioning secrets. \\

