{ outputs, inputs, }:
let
  addPatches = pkg: patches:
    pkg.overrideAttrs
    (oldAttrs: { patches = (oldAttrs.patches or [ ]) ++ patches; });
in {
  # For every flake input, aliases 'pkgs.inputs.${flake}' to
  # 'inputs.${flake}.packages.${pkgs.system}' or
  # 'inputs.${flake}.legacyPackages.${pkgs.system}'
  flake-inputs = final: _: {
    inputs = builtins.mapAttrs (_: flake:
      let
        legacyPackages = (flake.legacyPackages or { }).${final.system} or { };
        packages = (flake.packages or { }).${final.system} or { };
      in if legacyPackages != { } then legacyPackages else packages) inputs;
  };

  # Adds pkgs.stable == inputs.nixpkgs-stable.legacyPackages.${pkgs.system}
  stable = final: _: {
    stable = inputs.nixpkgs-stable.legacyPackages.${final.system};
  };

  # Adds my custom packages
  additions = final: prev:
    import ../pkgs { pkgs = final; } // {
      formats = (prev.formats or { })
        // import ../pkgs/formats { pkgs = final; };
      vimPlugins = (prev.vimPlugins or { })
        // import ../pkgs/vim-plugins { pkgs = final; };
    };

  # Modifies existing packages
  modifications = final: prev: {
    vimPlugins = prev.vimPlugins // {
      vim-numbertoggle = addPatches prev.vimPlugins.vim-numbertoggle
        [ ./vim-numbertoggle-command-mode.patch ];
    };

    # https://github.com/NixOS/nixpkgs/pull/303472
    gns3-server = prev.gns3-server.overrideAttrs (oldAttrs: {
      makeWrapperArgs =
        [ "--suffix PATH : ${final.lib.makeBinPath [ final.util-linux ]}" ];
    });

    # https://github.com/mdellweg/pass_secret_service/pull/37
    pass-secret-service =
      addPatches prev.pass-secret-service [ ./pass-secret-service-native.diff ];
  };
}
