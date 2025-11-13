{
  description = "pulsar-hs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/a493e93b4a259cd9fea8073f89a7ed9b1c5a1da2";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    ,
    }:
    let
      # Why do we need to `let`s? The overlay output should be system (platform) agnostic.
      packageOverlay = import ./nix/overlay.nix;
    in
    flake-utils.lib.eachDefaultSystem
      (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system}.extend packageOverlay;

          compiler = "ghc98";
          haskellPackages = pkgs.haskell.packages.${compiler};

          localHaskellPackages = {
            pulsar-client-hs = haskellPackages.pulsar-client-hs;
            pulsar-admin = haskellPackages.pulsar-admin;
          };

          devTools =
            with haskellPackages;
            [
              haskell-language-server
              ghcid
              cabal-install
              hlint
              c2hsc
              hsc2hs
            ]
            ++ [
              pkgs.haskell.compiler.${compiler}
            ];

          # Haskell packages in `packages` are not registered as packages in GHC.
          # Thus, we have to create one dedicated env per local Haskell package
          # to provide all of its dependecies.
          mkSingleDevShell =
            pkgName:
            haskellPackages.shellFor {
              packages = p: [ p.${pkgName} ];
              buildInputs = devTools;
            };

          haskellPackageNames = builtins.attrNames localHaskellPackages;

          mkPackageAttrs =
            pkgNames:
            builtins.listToAttrs (
              map
                (pkgName: {
                  name = pkgName;
                  value = haskellPackages.${pkgName};
                })
                pkgNames
            );
        in
        rec {
          packages = {
            default = pkgs.linkFarmFromDrvs "all-pulsar-hs" (builtins.attrValues localHaskellPackages);
            libpulsar = pkgs.libpulsar;
          }
          // mkPackageAttrs haskellPackageNames;


          devShells = {
            default = haskellPackages.shellFor {
              packages = p: builtins.attrValues localHaskellPackages;
              buildInputs = devTools;
            };
          }
          // builtins.listToAttrs (
            map
              (pkgName: {
                name = pkgName;
                value = mkSingleDevShell pkgName;
              })
              haskellPackageNames
          );
          formatter = pkgs.nixpkgs-fmt;
        }
      ) // {
      overlays = { default = packageOverlay; };
    };
}
