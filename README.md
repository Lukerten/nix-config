[![built with nix](https://img.shields.io/static/v1?logo=nixos&logoColor=white&label=&message=Built%20with%20Nix&color=41439a)](https://builtwithnix.org)
[![nixos-unstable](https://img.shields.io/badge/NixOS-Unstable-blue.svg?style=flat&logo=NixOS&logoColor=white)](https://nixos.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# Luke's NixOS Configurations

A comprehensive, modular NixOS and Home Manager configuration for managing multiple systems with a unified configuration approach.

## Systems Overview

| System           | Type    | Description              |
| ---------------- | ------- | ------------------------ |
| **annihilation** | Laptop  | Main development laptop  |
| **exaflare**     | Desktop | Home desktop workstation |
| **inception**    | Server  | Homelab server           |
| **sanctity**     | Server  | Secondary server         |

## Features

- **Modular Configuration**: Separate modules for different aspects of the system
- **Multiple System Support**: Single repository managing multiple machines
- **Declarative User Environment**: Home Manager configurations for complete user environment setup
- **Remote Deployment**: Using deploy-rs for deploying configurations to remote systems
- **Secret Management**: Using sops-nix for encrypting secrets
- **Custom Themes**: Unified theming across systems with nix-colors
- **Specialized Configurations**: For development, gaming, and server use cases

## Structure

```
.
├── flake.nix          # Main flake configuration
├── modules/           # Shared module configurations
│   ├── home-manager/  # Home Manager modules
│   └── nixos/         # NixOS modules
├── hosts/             # Host-specific configurations
├── home/              # Home Manager user configurations
├── overlays/          # Nixpkgs overlays
├── pkgs/              # Custom packages
├── templates/         # Nix flake templates
├── flake.nix          # Nixos Configuration flake
├── shell.nix          # Development Shell environment
├── hydra.nix          # Hydra building
├── deploy.nix         # deploy script
└── cleanup.nix        # cleanup script
```

## Key Components

- **NixOS Modules**: Reusable NixOS configuration components
- **Home Manager Modules**: User environment configurations
- **Flake Outputs**: Systems, packages, modules, and deployment configurations
- **Custom Overlays**: Package customizations and fixes
- **Deployment**: Remote system configurations via deploy-rs

## Usage

### Building a system

```bash
sudo nixos-rebuild switch --flake .#<hostname>
```

### Building a home configuration

```bash
home-manager switch --flake .#<username>@<hostname>
```

### Deploying to a remote system

```bash
./deploy.sh <hostname>
```

### Update dependencies

```bash
nix flake update
```

## Integrations

- **Firefox Addons**: Custom Firefox configurations and extensions
- **NixGL**: OpenGL/Vulkan support for graphical applications
- **Nix-gaming**: Optimized gaming configurations
- **Mailserver**: NixOS mailserver configurations for self-hosted email
- **NixVim**: Neovim configuration using Nix

## License

This project is licensed under the MIT License - see the LICENSE file for details.
