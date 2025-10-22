{ nixpkgs ? import ./nixpkgs.nix {}, compiler ? "ghc98" }:
let
  pkgs = import ./default.nix { inherit nixpkgs compiler; };
in
  nixpkgs.mkShell {
    buildInputs = [
      pkgs.pulsar-client-cpp
      nixpkgs.haskellPackages.ghcid
      nixpkgs.haskell.compiler.${compiler}
      nixpkgs.haskellPackages.c2hsc
      nixpkgs.haskellPackages.cabal-install
      nixpkgs.haskellPackages.hsc2hs
      (nixpkgs.haskell-language-server.override { supportedGhcVersions = [ (nixpkgs.lib.removePrefix "ghc" compiler) ]; })
    ];
  }
