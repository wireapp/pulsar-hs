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
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        packageOverlay = final: prev: {
          # Native C++ library. The original pulsar package is marked as
          # insecure, so we simply override it.
          pulsar-client-cpp = prev.libpulsar.overrideAttrs (old: {
            # N.B. patches need to be tracked by Git. Otherwise, Nix doesn't
            # pick them up!
            patches = (old.patches or [ ]) ++ [
              ./nix/add-stdbool-table-view.patch
            ];
          });
        };

        pkgs = nixpkgs.legacyPackages.${system}.extend packageOverlay;

        compiler = "ghc98";

        haskellPackages = pkgs.haskell.packages.${compiler}.override {
          overrides = self: super: {
            pulsar-client-hs = self.callCabal2nix "pulsar-client-hs" ./pulsar-client-hs {
              pulsar = pkgs.pulsar-client-cpp;
            };

            pulsar-admin = pkgs.haskell.lib.dontCheck (self.callCabal2nix "pulsar-admin" ./pulsar-admin { });
         };
        };

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
          pulsar-client-cpp = pkgs.pulsar-client-cpp;
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
    );
}
