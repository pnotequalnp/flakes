{
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] (system:
      let
        overlay = self: super: {
          haskell = super.haskell // {
            packageOverrides = hsSelf: hsSuper: {
              project = hsSelf.callCabal2nix "project" ./. { };
            };
          };
        };
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
        hs = pkgs.haskellPackages;
      in
      rec {
        inherit overlay;

        packages = rec {
          project = hs.project;
          default = project;
        };

        apps = rec {
          project = flake-utils.lib.mkApp { drv = packages.project; };
          default = project;
        };

        # Compatibility for older Nix versions
        defaultApp = apps.default;
        defaultPackage = packages.default;

        devShell = hs.shellFor {
          packages = hsPkgs: with hsPkgs; [ project ];
          nativeBuildInputs = with hs; [
            cabal-install
            fourmolu
            haskell-language-server
            hlint
          ];
        };
      });
}
