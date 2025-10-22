{ nixpkgs ? import ./nixpkgs.nix {}, compiler ? "ghc98" }:
let
  pkgs = import ./default.nix { inherit nixpkgs compiler; };
  haskellPackages = nixpkgs.haskellPackages.override {
    overrides = self: super: {
      pulsar-client-hs = pkgs.pulsar-client-hs;
    };
  };
in
haskellPackages.shellFor {
  packages = p: [ p.pulsar-client-hs ];

  buildInputs = [
    haskellPackages.ghcid
    nixpkgs.haskell.compiler.${compiler}
    haskellPackages.c2hsc
    haskellPackages.cabal-install
    haskellPackages.hsc2hs
    (nixpkgs.haskell-language-server.override {
      supportedGhcVersions = [ (nixpkgs.lib.removePrefix "ghc" compiler) ];
    })
  ];
}
