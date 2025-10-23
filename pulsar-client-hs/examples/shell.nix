{
  nixpkgs ? import ../nixpkgs.nix { },
  compiler ? "ghc98",
}:
let
  libPkgs = import ../default.nix { inherit nixpkgs compiler; };
  examplesPkg = import ./default.nix { inherit nixpkgs compiler; };
  haskellPackages = nixpkgs.haskellPackages.override {
    overrides = self: super: {
      pulsar-client-hs = libPkgs.pulsar-client-hs;
      pulsar-client-hs-examples = examplesPkg.pulsar-client-hs-examples;
    };
  };
in
haskellPackages.shellFor {
  packages = p: [ p.pulsar-client-hs-examples ];

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
