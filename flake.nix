{
  description = "pulsar-hs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/a493e93b4a259cd9fea8073f89a7ed9b1c5a1da2";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        compiler = "ghc98";
        haskellPackages = pkgs.haskell.packages.${compiler};

        # Native C++ library
        pulsar-client-cpp = pkgs.callPackage ./pulsar-client-hs/native {
          inherit (pkgs) stdenv lib pkgs boost177 cmake curl jsoncpp
                         log4cxx openssl pkgconf protobuf_26 python3
                         snappy zlib zstd fetchurl;
        };

      in
      rec
      {
        packages.pulsar-client-cpp = pulsar-client-cpp;

        packages.pulsar-client-hs =
          haskellPackages.callCabal2nix "pulsar-client-hs" ./pulsar-client-hs {
            pulsar = pulsar-client-cpp;
          };

        packages.pulsar-admin =
          pkgs.haskell.lib.dontCheck (
            haskellPackages.callCabal2nix "pulsar-admin" ./pulsar-admin {}
          );

        packages.pulsar-client-hs-examples =
          haskellPackages.callCabal2nix "pulsar-client-hs-examples" ./pulsar-client-hs/examples {
            pulsar-client-hs = packages.pulsar-client-hs;
          };

        defaultPackage = pkgs.linkFarmFromDrvs "all-pulsar-hs" [
          packages.pulsar-client-hs
          packages.pulsar-admin
          packages.pulsar-client-hs-examples
        ];

        devShell = pkgs.mkShell {
          buildInputs = with haskellPackages; [
            haskell-language-server
            ghcid
            cabal-install
            hlint
            c2hsc
            hsc2hs
          ] ++ [
            pkgs.haskell.compiler.${compiler}
          ];
          inputsFrom = builtins.attrValues self.packages.${system};
        };
      });
}
