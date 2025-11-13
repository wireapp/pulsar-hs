let
  haskellOverride = final: prev: self: super: {
    pulsar-client-hs = super.callCabal2nix "pulsar-client-hs" ../pulsar-client-hs {
      pulsar = final.libpulsar;
    };
    pulsar-admin = prev.haskell.lib.dontCheck (super.callCabal2nix "pulsar-admin" ../pulsar-admin { });
  };

  packageOverlay = final: prev: {
    libpulsar = prev.libpulsar.overrideAttrs (old: {
      patches = (old.patches or [ ]) ++ [
        ./add-stdbool-table-view.patch
      ];
    });

    haskellPackages = prev.haskellPackages.override { overrides = haskellOverride final prev; };

    haskell = prev.haskell // {
      packages =
        prev.haskell.packages
          // builtins.listToAttrs (
          map
            (compilerName: {
              name = compilerName;
              value = prev.haskell.packages.${compilerName}.override {
                overrides = haskellOverride final prev;
              };
            })
            (builtins.attrNames prev.haskell.packages)
        );
    };
  };
in
packageOverlay
