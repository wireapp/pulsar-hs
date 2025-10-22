{ packages ? import ./pkgs.nix { inherit compiler; }, compiler ? "ghc98" }:

let
  inherit (packages) pkgs hp;
  pulsar-admin = hp.callCabal2nix "pulsar-admin" ./. {};
in
  pkgs.haskell.lib.dontCheck pulsar-admin
