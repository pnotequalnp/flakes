{
  description = "Personal flake templates";

  outputs = { self }: {
    templates.cabal = {
        path = ./cabal;
        description = "Very basic flake with a callCabal2nix project";
      };
  };
}
