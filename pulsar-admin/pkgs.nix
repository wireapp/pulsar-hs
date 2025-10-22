{ compiler ? "ghc98" }:

let
  pkgs = import (
    builtins.fetchTarball {
      name   = "nixos-25.05";
      url    = "https://github.com/NixOS/nixpkgs/archive/a493e93b4a259cd9fea8073f89a7ed9b1c5a1da2.tar.gz";
      sha256 = "sha256:1pwnjxh0964w60g881da5gmpal42w2ikfccm1ng9hnb1w9i8vgsd";
    }
  ) {};

  hp = pkgs.haskell.packages.${compiler}.override {
    # overrides = newPkgs: oldPkgs: rec {
    #   network = newPkgs.network_3_1_2_2;
    # };
  };
in
{
  pkgs = pkgs;
  hp = hp;
}
