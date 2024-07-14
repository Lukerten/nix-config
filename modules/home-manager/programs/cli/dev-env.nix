{ config, pkgs, lib, ... }:
let cfg = config.programs.dev-env;
in {
  options.programs.dev-env = {
    enable = lib.mkEnableOption "dev-env";

    python = lib.mkOption {
      type = lib.types.package;
      default = pkgs.python312;
      description = "Python package to use";
    };

    pip = lib.mkOption {
      type = lib.types.package;
      default = pkgs.python312Packages.pip;
      description = "Pip package to use";
    };

    nodejs = lib.mkOption {
      type = lib.types.package;
      default = pkgs.nodejs;
      description = "NodeJS package to use";
    };

    java = lib.mkOption {
      type = lib.types.package;
      default = pkgs.jdk8;
      description = "Java package to use";
    };

    maven = lib.mkOption {
      type = lib.types.package;
      default = pkgs.maven;
      description = "Maven package to use";
    };

    gradle = lib.mkOption {
      type = lib.types.package;
      default = pkgs.gradle;
      description = "Gradle package to use";
    };

    cpp = lib.mkOption {
      type = lib.types.package;
      default = pkgs.gcc;
      description = "C++ package to use";
    };

    php = lib.mkOption {
      type = lib.types.package;
      default = pkgs.php;
      description = "PHP package to use";
    };

    go = lib.mkOption {
      type = lib.types.package;
      default = pkgs.go;
      description = "Go package to use";
    };

    lua = lib.mkOption {
      type = lib.types.package;
      default = pkgs.lua;
      description = "Lua package to use";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = [
        cfg.python
        cfg.pip
        cfg.nodejs
        cfg.java
        cfg.maven
        cfg.gradle
        cfg.cpp
        cfg.php
        cfg.go
        cfg.lua
      ];
    };
  };
}
