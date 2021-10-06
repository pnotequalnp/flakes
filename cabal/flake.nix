{
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        hs = pkgs.haskellPackages;
      in rec {
        packages.project = hs.callCabal2nix "project" ./. { };
        defaultPackage = packages.project;

        apps.project = flake-utils.lib.mkApp { drv = packages.project; };
        defaultApp = apps.project;

        devShell = packages.project.env.overrideAttrs
          (super: { buildInputs = super.buildInputs ++ [ hs.cabal-install ]; });
      });
}
